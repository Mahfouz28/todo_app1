import 'package:todo_app1/core/constanis/endpoint_constants%20(1).dart';
import 'package:todo_app1/core/network/dio_client.dart';
import 'package:todo_app1/homeScreen/model/note_model.dart';

class NoteRepo {
  final dio = DioClient();

  Future<List<NoteModel>> getAllNotes() async {
    try {
      final response = await dio.get(EndpointConstants.getAll);

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = response.data;

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
      throw Exception('Error fetching notes: $e');
    }
  }
}
