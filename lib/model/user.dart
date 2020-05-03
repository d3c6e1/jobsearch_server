import 'package:jobsearch_server/jobsearch_server.dart';
import 'package:jobsearch_server/model/document.dart';

class User extends ManagedObject<_User> implements _User{}

class _User {
  @primaryKey
  int id;

  @Column(unique: true)
  String name;

  @Column(nullable: true)
  String firstName;

  @Column(nullable: true)
  String lastName;

  @Column(nullable: true)
  String additionalName;

  @Column(nullable: true, unique: true)
  String email;

  ManagedSet<DocumentFile> documents;

}