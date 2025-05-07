// import 'package:http/http.dart' as http;

// class CreateWriterProvider {
//   Future<http.Response> createWriter({
//     required String name,
//     required String password,
//     required String passwordConfirmation,
//     //required String role,
//   }) async {
//     final response = await http.post(
//       Uri.parse('http://10.0.2.2:8000/api/register'),
//       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//       body: {
//         'name': name,
//         'password': password,
//         'password_confirmation': passwordConfirmation,
//        // 'role': role,
//       },
//     );
//     return response;
//   }
// }
