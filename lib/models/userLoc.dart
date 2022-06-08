import 'package:equatable/equatable.dart';

class UserLoc extends Equatable {
  final String id;
  final String name;
  final String lastName;
  final int age;
  final String gender;
  final String? image;
  final List<String>? positions;
  final List<String>? arbitrageTitles;

  UserLoc(this.id, this.name, this.lastName, this.age, this.gender, this.image,
      this.positions, this.arbitrageTitles);

  @override
  List<Object?> get props => [];

  Map<String, Object?> toFirebaseMap(
      {String? newImage,
      List<String>? newPositions,
      List<String>? newArbitrageTitles}) {
    return <String, Object?>{
      'id': id,
      'name': name,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      'image': newImage ?? image,
      'positions': newPositions ?? positions,
      'arbitrageTitles': newArbitrageTitles ?? arbitrageTitles,
    };
  }

  UserLoc.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        name = data['name'] as String,
        lastName = data['lastName'] as String,
        age = data['age'] as int,
        gender = data['gender'] as String,
        image = data['image'] as String?,
        positions = data['positions'] as List<String>?,
        arbitrageTitles = data['arbitrageTitles'] as List<String>?;
}
