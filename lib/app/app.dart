import 'package:flutter/material.dart';
import '../features/auth/ui/login_page.dart';
import '../features/auth/ui/signup_page.dart';
import '../features/posts/ui/create_post_page.dart';
import '../features/posts/ui/feed_page.dart';
import '../features/profile/ui/profile_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlashFeed',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/feed': (_) => const FeedPage(),
        '/create': (_) => const CreatePostPage(),
        '/profile': (_) => const ProfilePage(),
      },
    );
  }
}
