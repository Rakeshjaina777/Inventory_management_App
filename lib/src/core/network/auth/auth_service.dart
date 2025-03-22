// import 'package:dio/dio.dart';
//
// import '../endpoints.dart';
//
// class AuthService {
//   final Dio _dio = Dio();
//
//   Future<Map<String, dynamic>> signIn(String email, String password) async {
//     try {
//       final response = await _dio.post(
//         Endpoints.signin,
//         data: {"email": email, "password": password},
//       );
//
//       if (response.statusCode == 200) {
//         // Return the complete response data
//         return response.data;
//       } else {
//         throw Exception("Login failed");
//       }
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }
//
//
//   Future<Map<String, dynamic>> forgotPassword(String email) async {
//     try {
//       final response = await _dio.post(
//         Endpoints.forgotPassword,
//         data: {"email": email},
//       );
//       if (response.statusCode == 200) {
//         return response.data;
//       } else {
//         // If status code is not 200, we assume an error.
//         return response.data;
//       }
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }
//
//   Future<Map<String, dynamic>> setPassword(String token, String password, String confirmPassword) async {
//     try {
//       final response = await _dio.patch(
//         Endpoints.setPassword, // Define this in api_endpoints.dart
//         data: {
//           "password": password,
//           "confirmPassword": confirmPassword,
//         },
//         options: Options(
//           headers: {
//             "Authorization": "Bearer $token", // Passing token in header
//             "Content-Type": "application/json",
//           },
//         ),
//       );
//
//       return response.data; // Return response from API
//     } on DioException catch (e) {
//       return {
//         "error": e.response?.data["message"] ?? "An unexpected error occurred",
//       };
//     }
//   }
//
//   Future<Map<String, dynamic>> deleteUser(String email) async {
//     try {
//       final response = await _dio.delete(
//         Endpoints.deleteUser,
//         data: {"email": email},
//         options: Options(
//           headers: {"Content-Type": "application/json"},
//         ),
//       );
//
//       return response.data;
//     } on DioException catch (e) {
//       return {
//         "error": e.response?.data["message"] ?? "An unexpected error occurred",
//       };
//     }
//   }
// }
