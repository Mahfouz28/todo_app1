import 'package:todo_app1/core/constanis/endpoint_constants%20(1).dart';
import 'package:todo_app1/core/network/dio_client.dart';

class DeleteRepo {
  final dio = DioClient();

  Future<void> deleteNote(String noteId) async {
    try {
      final response = await dio.post(
        EndpointConstants.delete,
        queryParameters: {"note_id": noteId},
      );

      if (response.statusCode == 200 && response.data['status'] == "success") {
        return;
      } else {
        throw Exception(
          'Failed to delete note: ${response.data['message'] ?? 'Unknown error.'}',
        );
      }
    } catch (e) {
      throw Exception('Error while deleting note: $e');
    }
  }

  
}