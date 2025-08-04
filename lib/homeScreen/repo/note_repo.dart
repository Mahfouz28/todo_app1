import 'package:todo_app1/core/constanis/endpoint_constants%20(1).dart';
import 'package:todo_app1/core/network/dio_client.dart';
import 'package:todo_app1/homeScreen/model/note_model.dart';

/// Repository responsible for fetching notes from the backend.
class NoteRepo {
  final dio = DioClient(); // 🟢 API client instance

  /// Fetches all notes from the API.
  ///
  /// Returns:
  /// - A list of [NoteModel] if the request is successful.
  ///
  /// Throws:
  /// - [Exception] if the response format is unexpected or if an error occurs.
  Future<List<NoteModel>> getAllNotes() async {
    try {
      // 🔵 Send GET request to fetch notes
      final response = await dio.get(EndpointConstants.getAll);

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = response.data;

        // ✅ Ensure response structure is valid and contains a list of notes
        if (body['status'] == 'success' && body['data'] is List) {
          final List<dynamic> data = body['data'];
          return data.map((e) => NoteModel.fromJson(e)).toList();
        } else {
          throw Exception('Unexpected response format.');
        }
      } else {
        throw Exception(
          'Failed to load notes. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      // 🔴 Catch any error that happens during the request or parsing
      throw Exception('Error fetching notes: $e');
    }
  }
}
