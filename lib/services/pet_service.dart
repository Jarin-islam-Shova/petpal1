import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pet-model.dart';

class PetService {
  static const String baseUrl = 'https://api.example.com'; // Replace with actual API URL

  Future<List<Pet>> getPets({
    String? species,
    String? breed,
    int? age,
    String? gender,
  }) async {
    try {
      final queryParams = {
        if (species != null) 'species': species,
        if (breed != null) 'breed': breed,
        if (age != null) 'age': age.toString(),
        if (gender != null) 'gender': gender,
      };

      final uri = Uri.parse('$baseUrl/pets').replace(queryParameters: queryParams);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Pet.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load pets');
      }
    } catch (e) {
      throw Exception('Error fetching pets: $e');
    }
  }

  Future<Pet> getPetById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/pets/$id'));

      if (response.statusCode == 200) {
        return Pet.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load pet details');
      }
    } catch (e) {
      throw Exception('Error fetching pet details: $e');
    }
  }

  Future<void> submitAdoptionApplication(Map<String, dynamic> applicationData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/adoptions'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(applicationData),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to submit adoption application');
      }
    } catch (e) {
      throw Exception('Error submitting adoption application: $e');
    }
  }
}
