import 'package:jobsearch_server/jobsearch_server.dart';
import 'package:jobsearch_server/model/user.dart';

class IdentityController extends ResourceController {
  IdentityController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getIdentity() async {
    final userQuery = Query<User>(context)
      ..where((user) => user.id).equalTo(request.authorization.ownerID)
      ..join(set: (u) => u.cvs)
      ..join(set: (u) => u.documents)
      ..join(object: (u) => u.organization);

    final user = await userQuery.fetchOne();

    if (user == null) {
      return  Response.notFound();
    }

    return Response.ok(user);
  }
}