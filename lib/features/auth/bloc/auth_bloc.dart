import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../../services/auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService = AuthService();

  AuthBloc() : super(AuthInitial()) {

    // Check current user
    on<AuthCheckRequested>((event, emit) {
      final user = _authService.getCurrentUser();
      if (user != null) {
        emit(Authenticated(user.uid));
      } else {
        emit(Unauthenticated());
      }
    });

    // Sign in
    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _authService.signIn(event.email, event.password);
        if (user != null) {
          emit(Authenticated(user.uid));
        } else {
          emit(Unauthenticated(message: 'Invalid email or password'));
        }
      } catch (e) {
        emit(Unauthenticated(message: e.toString()));
      }
    });

    //Sign up
    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _authService.signUp(event.email, event.password);
        if (user != null) {
          emit(Authenticated(user.uid));
        } else {
          emit(Unauthenticated(message: 'Failed to create user'));
        }
      } catch (e) {
        emit(Unauthenticated(message: e.toString()));
      }
    });


    // Sign out
    on<SignOutRequested>((event, emit) async {
      try {
        await _authService.signOut();
        emit(Unauthenticated());
      } catch (e) {
        emit(Unauthenticated(message: e.toString()));
      }
    });
  }
}
