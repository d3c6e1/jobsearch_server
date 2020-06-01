import 'package:aqueduct/managed_auth.dart';
import 'package:jobsearch_server/jobsearch_server.dart';
import 'package:jobsearch_server/model/cv.dart';
import 'package:jobsearch_server/model/document_file.dart';
import 'package:jobsearch_server/model/organization.dart';

class User extends ManagedObject<_User> implements _User, ManagedAuthResourceOwner<_User> {
  @Serialize(input: true, output: false)
  String password;
}

class _User extends ResourceOwnerTableDefinition {
  @Column(nullable: true)
  String firstName;

  @Column(nullable: true)
  String lastName;

  @Column(nullable: true)
  String additionalName;

  @Column(nullable: true, unique: true)
  String email;

  @Column(nullable: true, unique: true)
  String phoneNumber;

  @Column(nullable: true)
  String city;

  @Column(nullable: true)
  Document socialNetworks;

  @Column(nullable: true)
  DateTime birthDate;

  ManagedSet<DocumentFile> documents;

  ManagedSet<CV> cvs;

  Organization organization;
}