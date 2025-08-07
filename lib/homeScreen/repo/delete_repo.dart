import 'package:todo_app1/core/constanis/endpoint_constants%20(1).dart';
import 'package:todo_app1/core/network/dio_client.dart';

class DeleteRepo {
  final dio = DioClient();

  Future<bool> deleteNote(String noteId) async {
    try {
      final response = await dio.post(
        EndpointConstants.delete,
        queryParameters: {"note_id": noteId},
      );

      final data = response.data;

      if (response.statusCode == 200 && data['status'] == "success") {
        return true;
      } else {
        final message = data['message']?.toString().toLowerCase() ?? '';

        // ✅ ignore error if note_id is invalid or already deleted
        if (message.contains("invalid note_id") ||
            message.contains("missing") ||
            message.contains("not found")) {
          return false; // مفيش داعي نرمي Exception
        }

        // ⛔️ باقي الأخطاء
        throw Exception(
          'Failed to delete note: ${data['message'] ?? 'Unknown error.'}',
        );
      }
    } catch (e) {
      print('Delete Error: $e');
      return false; // فشل الاتصال أو مشكلة مش متوقعة → تجاهل بردو لو حابب
    }
  }
}
