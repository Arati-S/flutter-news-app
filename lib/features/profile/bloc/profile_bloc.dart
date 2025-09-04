import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/features/profile/bloc/profile_event.dart';
import 'package:newsly/features/profile/bloc/profile_state.dart';

import '../../../services/post_service.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final PostService _postService;

  ProfileBloc(this._postService) : super(ProfileInitial()) {
    on<LoadPoints>((event, emit) async {
      emit(ProfileLoading());
      final points = await _postService.getTotalPoints();
      emit(ProfileLoaded(points));
    });
  }
}
