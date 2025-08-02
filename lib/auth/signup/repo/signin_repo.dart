import 'package:todo_app1/auth/signup/model/user_data.dart';
import 'package:todo_app1/core/constanis/endpoint_constants%20(1).dart';
import 'package:todo_app1/core/network/dio_client.dart';

class SigninRepo {
  final dio = DioClient();

  Future<UserData> signin(String name, String email, String password) async {
    final response = await dio.post(
      EndpointConstants.register,
      queryParameters: {"username": name, "email": email, "password": password},
    );

    if (response.statusCode == 200 && response.data["status"] != "failure") {
      return UserData.fromJson(response.data["data"]);
    } else {
      throw Exception(response.data['message'] ?? 'Unknown error');
    }
  }
}
