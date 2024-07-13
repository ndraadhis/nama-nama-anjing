import 'dart:convert';
import 'package:indraadhis_215410070/breed.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<List<Breed>> getBreeds() async {
    final response = await http.get(Uri.parse('https://dogapi.dog/api/v2/breeds'));

    if (response.statusCode == 200) {
      List<dynamic> breedsJson = json.decode(response.body)['data'];
      return breedsJson.map((json) => Breed.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load breeds');
    }
  }
}
