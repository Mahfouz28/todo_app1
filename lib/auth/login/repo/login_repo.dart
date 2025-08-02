import 'package:todo_app1/auth/login/model/usermodel.dart';
import 'package:todo_app1/core/constanis/endpoint_constants%20(1).dart';
import 'package:todo_app1/core/network/dio_client.dart';

class LoginRepo {
  final dio = DioClient();
  Future<UserModel> logIn(String email, String password) async {
    final response = await dio.post(
      EndpointConstants.login,
      queryParameters: {"email": email, "password": password},
    );
    if (response.statusCode == 200 && response.data["status"] != "failure") {
      return UserModel.fromJson(response.data["data"]);
    } else {
      throw Exception(response.data['message'] ?? 'Unknown error');
    }
  }
}
