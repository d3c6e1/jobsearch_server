import 'package:jobsearch_server/jobsearch_server.dart';
import 'package:jobsearch_server/model/vacancy.dart';

class VacanciesController extends ResourceController{
  VacanciesController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllVacancies({@Bind.query('name') String name}) async {
    final query = Query<Vacancy>(context)
      ..join(object: (v) => v.owner);

    if (name != null) {
      query.where((vacancy) => vacancy.name).contains(name, caseSensitive: false);
    }
    final vacancies = await query.fetch();

    return Response.ok(vacancies);
  }

  @Operation.get('id')
  Future<Response> getvacancyByID(@Bind.path('id') int id) async {
    final query = Query<Vacancy>(context)
      ..where((vacancy) => vacancy.id).equalTo(id)
      ..join(object: (v) => v.owner);

    final vacancy = await query.fetchOne();

    if(vacancy == null) {
      return Response.notFound();
    }
    return Response.ok(vacancy);
  }

  @Operation.post()
  Future<Response> createVacancy(@Bind.body(ignore: ["id"]) Vacancy vacancy) async {
    final query = Query<Vacancy>(context)
      ..values = vacancy;

    final insertedVacancy = await query.insert();

    return Response.ok(insertedVacancy);
  }
}