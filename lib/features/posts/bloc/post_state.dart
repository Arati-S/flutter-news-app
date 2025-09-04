import 'package:equatable/equatable.dart';

class Post {
  final String id;
  final String text;
  final String? imageUrl;

  Post({required this.id, required this.text, this.imageUrl});
}

abstract class PostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;

  PostLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class PostError extends PostState {
  final String message;

  PostError(this.message);

  @override
  List<Object?> get props => [message];
}
