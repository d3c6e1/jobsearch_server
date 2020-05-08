import 'package:aqueduct/managed_auth.dart';
import 'package:jobsearch_server/controller/cv_controller.dart';
import 'package:jobsearch_server/controller/doc_files_controller.dart';
import 'package:jobsearch_server/controller/organization_controller.dart';
import 'package:jobsearch_server/controller/register_controller.dart';
import 'package:jobsearch_server/controller/users_controller.dart';
import 'package:jobsearch_server/controller/vacancies_controller.dart';
import 'package:jobsearch_server/model/user.dart';
import 'jobsearch_server.dart';

class JobsearchConfiguration extends Configuration {
  JobsearchConfiguration(String configPath) : super.fromFile(File(configPath));

  DatabaseConfiguration database;
}

class JobsearchServerChannel extends ApplicationChannel {
  ManagedContext context;

  AuthServer authServer;

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final config = JobsearchConfiguration(options.configurationFilePath);
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
      config.database.username,
      config.database.password,
      config.database.host,
      config.database.port,
      config.database.databaseName);

    context = ManagedContext(dataModel, persistentStore);

    final authStorage = ManagedAuthDelegate<User>(context);
    authServer = AuthServer(authStorage);
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router
      .route('/register')
      .link(() => RegisterController(context, authServer));

    router
      .route('/auth/token')
      .link(() => AuthController(authServer));

    router
      .route('/files/[:id]')
      .link(() => Authorizer.bearer(authServer))
      .link(() => DocumentFilesController(context));

    router
      .route('/users/[:id]')
      .link(() => UsersController(context));

    router
      .route('/organizations/[:id]')
      .link(() => OrganizationController(context));

    router
      .route('/cvs/[:id]')
      .link(() => CVController(context));
    
    router
      .route('/vacancies/[:id]')
      .link(() => VacanciesController(context));

    return router;
  }
}