import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/services/post_service.dart';
import 'app/app.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/bloc/auth_event.dart';
import 'features/posts/bloc/post_bloc.dart';
import 'features/profile/bloc/profile_bloc.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final postService = PostService();
  final profileBloc = ProfileBloc(postService);

  // Firebase initialize
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => AuthBloc()..add(AuthCheckRequested())),
      BlocProvider(create: (_) => PostBloc(postService, profileBloc)), // pass ProfileBloc reference
      BlocProvider(create: (_) => ProfileBloc(postService)),
    ],
    child: const App(),
  ));
}
