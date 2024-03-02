import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quadball_manager/services/auth_repository_base.dart';

class AuthRepository extends AuthRepositoryBase {
  final _firebaseAuth = FirebaseAuth.instance;

  AuthUser? _userFromFirebase(User? user) =>
      user == null ? null : AuthUser(user.uid, user.email);

  @override
  Stream<AuthUser?> get onAuthStateChanged =>
      _firebaseAuth.authStateChanges().asyncMap(_userFromFirebase);

  @override
  Future<AuthUser?> singIn() {
    throw UnimplementedError();
  }

  @override
  Future<AuthUser?> singInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();

    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<AuthUser?> createUserWithEmailPwd(String email, String pwd) async {
    final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: pwd);

    return _userFromFirebase(result.user);
  }

  @override
  Future<AuthUser?> singInWithEmailPwd(String email, String pwd) async {
    final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: pwd);

    return _userFromFirebase(result.user);
  }

  @override
  Future<void> singOut() async {
    await GoogleSignIn().signOut();
    await _firebaseAuth.signOut();
  }
}
