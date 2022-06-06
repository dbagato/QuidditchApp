import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quidditch_app/services/auth_repository_base.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepositoryBase _authRepository;
  late StreamSubscription _authSubscription;
  AuthCubit(this._authRepository) : super(AuthInitialState());

  //Funcion que quedara a la escucha cuando el estado cambie
  Future<void> init() async {
    _authSubscription =
        _authRepository.onAuthStateChanged.listen(_authStateChanged);
  }

  //Funcion para emitir el estado
  void _authStateChanged(AuthUser? user) =>
      {user == null ? emit(AuthSignedOut()) : emit(AuthSignedIn(user))};

  void singInWithGoogle() => _signIn(_authRepository.singInWithGoogle());

  void singInWithFacebook() => _signIn(_authRepository.singInWithFacebook());

  void createUserWithEmailPwd(String email, String pwd) =>
      _signIn(_authRepository.createUserWithEmailPwd(email, pwd));
  //Funcion para iniciar sesion
  void _signIn(Future<AuthUser?> auxUser) async {
    try {
      emit(AuthSigningIn());
      final user = await auxUser;
      if (user == null) {
        emit(AuthError('Unknown Error, Please try againg later.'));
      } else {
        emit(AuthSignedIn(user));
      }
    } catch (e) {
      emit(AuthError('Error: ' + e.toString()));
    }
  }

  Future<void> signOut() async {
    await _authRepository.singOut();
    emit(AuthSignedOut());
  }

  //funcion que cerrara el stream
  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

//estado inicial de la aplicaion
class AuthInitialState extends AuthState {}

//estado para cuando un usuario no esta logueado
class AuthSignedOut extends AuthState {}

//estado cuando un usuario se esta logueando
class AuthSigningIn extends AuthState {}

//estado para manejar errores de la aplicaion
class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

//estado para usuario logeado
class AuthSignedIn extends AuthState {
  final AuthUser user;

  AuthSignedIn(this.user);

  @override
  List<Object?> get props => [user];
}
