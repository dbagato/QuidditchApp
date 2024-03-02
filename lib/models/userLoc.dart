import 'package:equatable/equatable.dart';

class UserLoc extends Equatable {
  final String id;
  final String name;
  final String lastName;
  final int age;
  final String gender;
  final String rol;
  final String? image;
  final List<dynamic>? positions;
  final List<dynamic>? arbitrageTitles;

  const UserLoc(this.id, this.name, this.lastName, this.age, this.gender,
      this.rol, this.image, this.positions, this.arbitrageTitles);

  @override
  List<Object?> get props => [];

  Map<String, Object?> toFirebaseMap(
      {String? newImage,
      List<dynamic>? newPositions,
      List<dynamic>? newArbitrageTitles}) {
    return <String, Object?>{
      'id': id,
      'name': name,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      'rol': rol,
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
        rol = data['rol'] as String,
        image = data['image'] as String?,
        positions = data['positions'] as List<dynamic>?,
        arbitrageTitles = data['arbitrageTitles'] as List<dynamic>?;
}
