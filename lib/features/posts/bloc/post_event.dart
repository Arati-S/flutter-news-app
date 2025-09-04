import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPosts extends PostEvent {}

class CreatePost extends PostEvent {
  final String text;
  final String? imageUrl;

  CreatePost({required this.text, this.imageUrl});

  @override
  List<Object?> get props => [text, imageUrl];
}
