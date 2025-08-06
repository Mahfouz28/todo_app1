import 'package:todo_app1/core/constanis/endpoint_constants%20(1).dart';
import 'package:todo_app1/core/network/dio_client.dart';

class EditRepo {
  final dio = DioClient();

  Future<void> editNote(String noteId, String title, String content) async {
    try {
      final response = await dio.post(
        EndpointConstants.edit,
        queryParameters: {
          "note_id": noteId,
          "title": title,
          "content": content,
        },
      );

      if (response.statusCode == 200 && response.data['status'] == "success") {
        return;
      } else {
        throw Exception(
          'Failed to edit note: ${response.data['message'] ?? 'Unknown error.'}',
        );
      }
    } catch (e) {
      throw Exception('Error while editing note: $e');
    }
  }

  
}