import 'package:jobsearch_server/jobsearch_server.dart';
import 'package:jobsearch_server/model/user.dart';

enum _DocumentFileType {
  passport, other
}

class DocumentFile extends ManagedObject<_DocumentFile> implements _DocumentFile{}

class _DocumentFile {
  @primaryKey
  int id;

  _DocumentFileType type;

  @Column(unique: true)
  String filePath;

  // @Relate(#documents, onDelete: DeleteRule.cascade)
  // User owner;
}