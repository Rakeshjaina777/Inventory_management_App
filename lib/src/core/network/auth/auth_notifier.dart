// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import 'auth_repository.dart';
//
// class AuthState {
//   final bool isLoading;
//   final String? token;
//   final String? message;
//   final String? error;
//
//   AuthState({
//     this.isLoading = false,
//     this.token,
//     this.message,
//     this.error,
//   });
// }
//
// class AuthNotifier extends StateNotifier<AuthState> {
//   final AuthRepository _authRepository;
//
//   AuthNotifier(this._authRepository) : super(AuthState());
//
//   Future<void> signIn(String email, String password) async {
//     state = AuthState(isLoading: true);
//
//     try {
//       final response = await _authRepository.signIn(email, password);
//       // Check if the response message is "OTP sent"
//       if (response['message'] == "OTP sent") {
//         state = AuthState(token: response['data'], message: response['message']);
//       } else {
//         state = AuthState(error: "Unexpected response: ${response['message']}");
//       }
//     } catch (e) {
//       state = AuthState(error: e.toString());
//     }
//   }
//
//   Future<void> forgotPassword(String email) async {
//     state = AuthState(isLoading: true);
//     try {
//       final response = await _authRepository.forgotPassword(email);
//
//       // Log response for debugging
//       print("Forgot Password Response: $response");
//
//       // Successful response: statusCode 200 and message "OTP sent"
//       if (response['statusCode'] == 200 && response['message'] == "OTP sent") {
//         state = AuthState(
//           message: response['message'],
//           token: response['data'],  // ✅ Save token from response
//         );
//       } else {
//         state = AuthState(error: response['message'] ?? "Unexpected error");
//       }
//     } catch (e) {
//       state = AuthState(error: e.toString());
//     }
//   }
//
//
//   Future<void> setPassword(String token, String password, String confirmPassword) async {
//     state = AuthState(isLoading: true);
//     try {
//       final response = await _authRepository.setPassword(token, password, confirmPassword);
//
//       if (response.containsKey("error")) {
//         state = AuthState(error: response["error"]);
//       } else {
//         state = AuthState(message: "Password set successfully");
//       }
//     } catch (e) {
//       state = AuthState(error: e.toString());
//     }
//   }
//
//
//   Future<void> deleteUser(String email) async {
//     state = AuthState(isLoading: true);
//     try {
//       final response = await _authRepository.deleteUser(email);
//
//       if (response.containsKey("error")) {
//         state = AuthState(error: response["error"]);
//       } else {
//         state = AuthState(message: "User deleted successfully");
//       }
//     } catch (e) {
//       state = AuthState(error: e.toString());
//     }
//   }
//
// }
