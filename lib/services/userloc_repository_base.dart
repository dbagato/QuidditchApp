import 'dart:io';

import 'package:quidditch_app/models/models.dart';

abstract class UserLocRepositoryBase {
  Future<UserLoc?> getUserLoc();

  Future<List<UserLoc?>?> getAllUserLoc();

  Future<void> saveUserLoc(UserLoc user, File? image);
}
