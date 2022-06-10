import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quidditch_app/models/models.dart';
import 'package:quidditch_app/services/userloc_repository_base.dart';

class UserLocCubit extends Cubit<UserLocState> {
  final UserLocRepositoryBase _userLocRepository;

  File? _pickedImage;
  UserLoc? _user;
  List<String>? _pickPositions;
  List<String>? _pickArbitrageTitles;

  UserLocCubit(this._userLocRepository) : super(UserLocLoadingState());

  void setImage(File? imageFile) {
    _pickedImage = imageFile;
    emit(UserLocReadyState.image(_user!, _pickedImage));
  }

  void setPositions(List<String> positions) {
    _pickPositions = positions;
    emit(UserLocReadyState.pickPositions(_user!, _pickedImage, _pickPositions));
  }

  void setArbitrageTitles(List<String> arbitrageTitles) {
    _pickArbitrageTitles = arbitrageTitles;
    emit(UserLocReadyState.pickPositions(
        _user!, _pickedImage, _pickArbitrageTitles));
  }

  Future<void> getUserLoc() async {
    emit(UserLocLoadingState());
    _user = await _userLocRepository.getUserLoc();
    if (_user == null) {
      _user = UserLoc('', '', '', 0, '', '', '', [], []);
    }
    emit(UserLocReadyState(
        _user!, _pickedImage, _pickPositions, _pickArbitrageTitles));
  }

  Future<void> saveUserLoc(
      String id,
      String name,
      String lastName,
      int age,
      String gender,
      String rol,
      List<String>? positions,
      List<String>? arbitrageTitles) async {
    _user = UserLoc(id, name, lastName, age, gender, rol, _user!.image,
        positions, arbitrageTitles);
    emit(UserLocReadyState(
        _user, _pickedImage, _pickPositions, _pickArbitrageTitles,
        isSaving: true));
    //TODO quitar el delayed
    await Future.delayed(const Duration(seconds: 3));
    await _userLocRepository.saveUserLoc(_user!, _pickedImage);
    emit(UserLocReadyState(
        _user, _pickedImage, _pickPositions, _pickArbitrageTitles,
        isSaving: false));
  }
}

abstract class UserLocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserLocLoadingState extends UserLocState {}

class UserLocReadyState extends UserLocState {
  final UserLoc? user;
  final File? pickedImage;
  List<String>? pickPositions = [];
  List<String>? pickArbitrageTitles = [];
  final bool isSaving;

  UserLocReadyState(
      this.user, this.pickedImage, this.pickPositions, this.pickArbitrageTitles,
      {this.isSaving = false});

  UserLocReadyState.image(this.user, this.pickedImage, {this.isSaving = false});

  UserLocReadyState.pickPositions(
      this.user, this.pickedImage, this.pickPositions,
      {this.isSaving = false});
  UserLocReadyState.pickArbitrageTitles(
      this.user, this.pickedImage, this.pickArbitrageTitles,
      {this.isSaving = false});

  @override
  List<Object?> get props =>
      [user, pickedImage?.path, pickPositions, pickArbitrageTitles];
}
