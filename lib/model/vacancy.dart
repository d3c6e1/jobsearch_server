import 'package:jobsearch_server/jobsearch_server.dart';
import 'package:jobsearch_server/model/organization.dart';

class Vacancy extends ManagedObject<_Vacancy> implements _Vacancy{}

class _Vacancy {
  @primaryKey
  int id;

  @Column()
  String name;

  @Column()
  DateTime publishDate;

  @Relate(#vacancies, onDelete: DeleteRule.cascade)
  Organization owner;

  @Column()
  Document data;
}