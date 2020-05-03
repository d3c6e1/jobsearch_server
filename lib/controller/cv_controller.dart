import 'package:jobsearch_server/jobsearch_server.dart';
import 'package:jobsearch_server/model/cv.dart';

class CVController extends ResourceController{
  CVController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllCVs({@Bind.query('name') String name}) async {
    final query = Query<CV>(context);
    if (name != null) {
      query.where((cv) => cv.name).contains(name, caseSensitive: false);
    }
    final cvs = await query.fetch();

    return Response.ok(cvs);
  }

  @Operation.get('id')
  Future<Response> getCVByID(@Bind.path('id') int id) async {
    final query = Query<CV>(context)
      ..where((cv) => cv.id).equalTo(id);

    final cv = await query.fetchOne();

    if(cv == null) {
      return Response.notFound();
    }
    return Response.ok(cv);
  }
}