import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Check current user
class AuthCheckRequested extends AuthEvent {}

// Sign in
class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

// Sign up
class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  SignUpRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

// Sign out
class SignOutRequested extends AuthEvent {}
