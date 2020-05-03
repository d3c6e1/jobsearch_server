import 'package:jobsearch_server/jobsearch_server.dart';
import 'package:jobsearch_server/model/organization.dart';

class OrganizationController extends ResourceController{
  OrganizationController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllOrganiztions({@Bind.query('name') String name}) async {
    final query = Query<Organization>(context);
    if (name != null) {
      query.where((org) => org.name).contains(name, caseSensitive: false);
    }
    final orgs = await query.fetch();

    return Response.ok(orgs);
  }

  @Operation.get('id')
  Future<Response> getOrganizationByID(@Bind.path('id') int id) async {
    final query = Query<Organization>(context)
      ..where((org) => org.id).equalTo(id);

    final org = await query.fetchOne();

    if(org == null) {
      return Response.notFound();
    }
    return Response.ok(org);
  }
}