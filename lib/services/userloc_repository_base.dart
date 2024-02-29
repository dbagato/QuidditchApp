import 'dart:io';

import 'package:quadball_manager/models/models.dart';

abstract class UserLocRepositoryBase {
  Future<UserLoc?> getUserLoc();

  Future<List<UserLoc?>?> getAllUserLoc();

  Future<void> saveUserLoc(UserLoc user, File? image);
}
