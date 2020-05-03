import 'package:jobsearch_server/controller/cv_controller.dart';
import 'package:jobsearch_server/controller/doc_files_controller.dart';
import 'package:jobsearch_server/controller/organization_controller.dart';
import 'package:jobsearch_server/controller/vacancies_controller.dart';
import 'controller/users_controller.dart';
import 'jobsearch_server.dart';

class JobsearchConfiguration extends Configuration {
  JobsearchConfiguration(String configPath) : super.fromFile(File(configPath));

  DatabaseConfiguration database;
}

class JobsearchServerChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    final config = JobsearchConfiguration(options.configurationFilePath);

    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
      config.database.username,
      config.database.password,
      config.database.host,
      config.database.port,
      config.database.databaseName);

    context = ManagedContext(dataModel, persistentStore);
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router
    .route('/users/[:id]')
    .link(() => UsersController(context));

    router
    .route('/files/[:id]')
    .link(() => DocumentFilesController(context));

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