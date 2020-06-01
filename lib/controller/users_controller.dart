import 'package:jobsearch_server/jobsearch_server.dart';
import 'package:jobsearch_server/model/user.dart';

class UsersController extends ResourceController {
  
  UsersController(this.context);

  final ManagedContext context;
  
  @Operation.get()
  Future<Response> getAllUsers({@Bind.query('username') String username}) async {
    final userQuery = Query<User>(context)
      ..join(set: (u) => u.cvs)
      ..join(set: (u) => u.documents)
      ..join(object: (u) => u.organization);
    
    if (username != null) {
      userQuery.where((user) => user.username).contains(username, caseSensitive: false);
    }
    final users = await userQuery.fetch();

    return Response.ok(users);
  }

  @Operation.get('id')
  Future<Response> getUserByID(@Bind.path('id') int id) async {
    final userQuery = Query<User>(context)
      ..where((user) => user.id).equalTo(id)
      ..join(set: (u) => u.cvs)
      ..join(set: (u) => u.documents)
      ..join(object: (u) => u.organization);

    final user = await userQuery.fetchOne();

    if(user == null) {
      return Response.notFound();
    }
    return Response.ok(user);
  }
}