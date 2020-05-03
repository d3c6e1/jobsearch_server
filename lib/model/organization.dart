import 'package:jobsearch_server/jobsearch_server.dart';
import 'package:jobsearch_server/model/user.dart';
import 'package:jobsearch_server/model/vacancy.dart';


class Organization extends ManagedObject<_Organization> implements _Organization{}

class _Organization {
  @primaryKey
  int id;

  @Column(unique: true)
  String name;

  @Relate(#organization, onDelete: DeleteRule.cascade)
  User owner;

  ManagedSet<Vacancy> vacancies;
}