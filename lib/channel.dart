import 'package:aqueduct/managed_auth.dart';
import 'package:jobsearch_server/controller/controller.dart';
import 'package:jobsearch_server/model/model.dart';
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
    Controller.includeErrorDetailsInServerErrorResponses = true;
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
    /* OAuth 2.0 Resource Owner Grant Endpoint */
    router
      .route('/auth/token')
      .link(() => AuthController(authServer));

    /* Create an account */
    router
      .route('/register')
      .link(() => Authorizer.basic(authServer))
      .link(() => RegisterController(context, authServer));
      
    /* Gets profile for user with bearer token */
    router
      .route('/profile')
      .link(() => Authorizer.bearer(authServer))
      .link(() => IdentityController(context));

    router
      .route('/files/[:id]')
      .link(() => Authorizer.bearer(authServer))
      .link(() => DocumentFilesController(context));

    router
      .route('/users/[:id]')
      .link(() => Authorizer.basic(authServer))
      .link(() => UsersController(context));

    router
      .route('/organizations/[:id]')
      .link(() => OrganizationController(context));

    router
      .route('/cvs[/:id]')
      .link(() => Authorizer.basic(authServer))
      .link(() => CVController(context));
    
    router
      .route('/vacancies/[:id]')
      .link(() => VacanciesController(context));

    return router;
  }
}