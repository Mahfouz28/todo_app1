import 'package:todo_app1/core/constanis/endpoint_constants%20(1).dart';
import 'package:todo_app1/homeScreen/model/not_add_model.dart';
import 'package:todo_app1/core/network/dio_client.dart';

/// Repository responsible for sending a new note to the server.
class NoteAddRepo {
  final dio = DioClient(); // 🟢 Initialized DioClient for API calls

  /// Adds a new note by sending a POST request to the API.
  ///
  /// Parameters:
  /// - [title]   : Note title
  /// - [content] : Note content
  /// - [usersId] : User ID as a string
  ///
  /// Returns:
  /// - [NoteAddModel] if successful
  ///
  /// Throws:
  /// - [Exception] if the request fails or returns an unexpected response
  Future<NoteAddModel> addNote(
    String title,
    String content,
    String usersId,
  ) async {
    try {
      final response = await dio.post(
        EndpointConstants.addNote,
        queryParameters: {
          "title": title,
          "message": content ,
          "users_id": usersId,
        },
      );

      if (response.statusCode == 200 && response.data['status'] == "success") {
        return NoteAddModel.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to add note: ${response.data['content'] ?? 'Unexpected error.'}',
        );
      }
    } catch (e) {
      throw Exception('Error while adding note: $e');
    }
  }
}
