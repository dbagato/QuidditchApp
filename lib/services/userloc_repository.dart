import 'package:quadball_manager/models/models.dart';
import 'package:quadball_manager/services/firebase_provider.dart';
import 'dart:io';

import 'package:quadball_manager/services/userloc_repository_base.dart';

class UserLocRepository extends UserLocRepositoryBase {
  final provider = FirebaseProvider();

  @override
  Future<UserLoc?> getUserLoc() => provider.getUserLoc();

  @override
  Future<List<UserLoc?>?> getAllUserLoc() => provider.getAllUserLoc();

  @override
  Future<void> saveUserLoc(UserLoc user, File? image) =>
      provider.saveUserLoc(user, image);
}
