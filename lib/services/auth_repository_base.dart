import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  String uid;
  String? email;

  AuthUser(this.uid, this.email);

  @override
  List<Object?> get props => [uid];
}

abstract class AuthRepositoryBase {
  Stream<AuthUser?> get onAuthStateChanged;
  Future<AuthUser?> singIn();
  Future<AuthUser?> singInWithGoogle();
  Future<AuthUser?> createUserWithEmailPwd(String email, String pwd);
  Future<AuthUser?> singInWithEmailPwd(String email, String pwd);
  Future<void> singOut();
}
