import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class DataService {
  final _baseUrl = 'api.npoint.io';

  Future<List<Post>> getPosts() async {
    try {
      final uri = Uri.https(_baseUrl, '/04d3d044e6275c800d78');
      final response = await http.get(uri);
      final json = jsonDecode(response.body) as List;
      final posts = json.map((postJson) => Post.fromJson(postJson)).toList();
      return posts;
    } catch (e) {
      rethrow;
    }
  }
}
