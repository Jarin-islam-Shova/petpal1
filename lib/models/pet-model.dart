class Pet {
  final String id;
  final String name;
  final String species;
  final String breed;
  final int age;
  final String gender;
  final String description;
  final List<String> images;
  final String status;
  final Map<String, dynamic> healthDetails;

  Pet({
    required this.id,
    required this.name,
    required this.species,
    required this.breed,
    required this.age,
    required this.gender,
    required this.description,
    required this.images,
    required this.status,
    required this.healthDetails,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      name: json['name'],
      species: json['species'],
      breed: json['breed'],
      age: json['age'],
      gender: json['gender'],
      description: json['description'],
      images: List<String>.from(json['images']),
      status: json['status'],
      healthDetails: json['healthDetails'],
    );
  }
}
