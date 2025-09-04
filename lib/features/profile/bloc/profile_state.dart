import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final int points;

  ProfileLoaded(this.points);

  @override
  List<Object?> get props => [points];
}
