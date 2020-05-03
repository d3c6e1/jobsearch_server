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




    return router;
  }
}