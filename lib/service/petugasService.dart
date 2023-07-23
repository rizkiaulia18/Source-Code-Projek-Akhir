// import 'package:simasjid/model/petugas.dart';
// import 'package:http/http.dart' as http;

// class PetugasService {
//   static final String _baseUrl = 'http://192.168.32.124/simasjid/api/agenda/';

//   Future getPetugas() async {
//     Uri urlApi = Uri.parse(_baseUrl);

//     final response = await http.get(urlApi);
//     if (response.statusCode == 200) {
//       return petugasFromJson(response.body.toString());
//     } else {
//       throw Exception("Failed to load data petugas");
//     }
//   }
// }
