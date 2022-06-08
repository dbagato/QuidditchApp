import 'package:quidditch_app/models/models.dart';
import 'package:quidditch_app/services/firebase_provider.dart';
import 'dart:io';

import 'package:quidditch_app/services/userloc_repository_base.dart';

class UserLocRepository extends UserLocRepositoryBase {
  final provider = FirebaseProvider();

  @override
  Future<UserLoc?> getUserLoc() => provider.getUserLoc();

  @override
  Future<void> saveUserLoc(UserLoc user, File? image) =>
      provider.saveUserLoc(user, image);
}
