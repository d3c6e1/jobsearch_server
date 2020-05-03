import 'package:jobsearch_server/jobsearch_server.dart';
import 'package:jobsearch_server/model/document_file.dart';

class DocumentFilesController extends ResourceController{

  DocumentFilesController(this.context);

  final ManagedContext context;

  @Operation.get('id')
  Future<Response> getDocumentFileByID(@Bind.path('id') int id) async {
    final docQuery = Query<DocumentFile>(context)
      ..where((doc) => doc.id).equalTo(id);

    final doc = await docQuery.fetchOne();

    if(doc == null) {
      return Response.notFound();
    }
    return Response.ok(doc);
  }
}