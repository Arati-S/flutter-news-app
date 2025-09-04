import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/features/posts/bloc/post_event.dart';
import 'package:newsly/features/posts/bloc/post_state.dart';

import '../../../services/post_service.dart';
import '../../profile/bloc/profile_bloc.dart';
import '../../profile/bloc/profile_event.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostService _postService;
  final ProfileBloc _profileBloc; // <- add this

  PostBloc(this._postService, this._profileBloc) : super(PostInitial()) {
    on<LoadPosts>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await _postService.fetchPosts();
        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });

    on<CreatePost>((event, emit) async {
      try {
        await _postService.createPost(event.text, event.imageUrl);

        // Notify ProfileBloc to reload points
        _profileBloc.add(LoadPoints());

        add(LoadPosts()); // refresh posts
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });
  }
}
