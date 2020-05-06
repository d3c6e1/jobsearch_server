import 'package:jobsearch_server/jobsearch_server.dart';
import 'package:jobsearch_server/model/user.dart';


class CV extends ManagedObject<_CV> implements _CV{}

class _CV {
  @primaryKey
  int id;

  @Column()
  String name;

  @Column()
  DateTime publishDate;

  // @Relate(#cvs, onDelete: DeleteRule.cascade)
  // User owner;

  @Column()
  Document data;
}