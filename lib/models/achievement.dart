import 'package:cloud_firestore/cloud_firestore.dart';

class Achievement {
  final String name;
  final String description;
  final String imageUrl;

  const Achievement({
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory Achievement.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Achievement(
      name: snapshot['name'],
      description: snapshot['description'],
      imageUrl: snapshot['image_url'],
    );
  }
}
