import 'package:jobsearch_server/jobsearch_server.dart';
import 'package:jobsearch_server/model/user.dart';

class IdentityController extends ResourceController {
  IdentityController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getIdentity() async {
    var q = Query<User>(context)
      ..where((u) => u.id).equalTo(request.authorization.ownerID);

    var user = await q.fetchOne();
    if (user == null) {
      return  Response.notFound();
    }

    return Response.ok(user);
  }
}