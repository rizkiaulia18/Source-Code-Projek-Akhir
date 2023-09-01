import 'package:simasjid/model/agenda.dart';
import 'package:http/http.dart' as http;
import 'package:simasjid/service/url.dart';

class AgendaService {
  static final String _baseUrl = '${BaseUrl.baseUrl}ApiAgenda/';

  Future getAgenda() async {
    Uri urlApi = Uri.parse(_baseUrl);

    final response = await http.get(urlApi);
    if (response.statusCode == 200) {
      return agendaFromJson(response.body.toString());
    } else {
      throw Exception("Failed to load data Agenda");
    }
  }
}
