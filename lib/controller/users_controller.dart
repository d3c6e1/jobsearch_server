import 'package:jobsearch_server/jobsearch_server.dart';
import 'package:jobsearch_server/model/user.dart';

class UsersController extends ResourceController {
  
  UsersController(this.context);

  final ManagedContext context;
  
  @Operation.get()
  Future<Response> getAllUsers({@Bind.query('name') String name}) async {
    final userQuery = Query<User>(context);
    if (name != null) {
      userQuery.where((user) => user.name).contains(name, caseSensitive: false);
    }
    final users = await userQuery.fetch();

    return Response.ok(users);
  }

  @Operation.get('id')
  Future<Response> getUserByID(@Bind.path('id') int id) async {
    final userQuery = Query<User>(context)
      ..where((user) => user.id).equalTo(id);

    final user = await userQuery.fetchOne();

    if(user == null) {
      return Response.notFound();
    }
    return Response.ok(user);
  }
}