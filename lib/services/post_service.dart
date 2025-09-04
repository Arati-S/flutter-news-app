import '../features/posts/bloc/post_state.dart';

class PostService {
  static final PostService _instance = PostService._internal();
  factory PostService() => _instance;
  PostService._internal();

  final List<Post> _posts = [];

  Future<List<Post>> fetchPosts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _posts;
  }

  Future<void> createPost(String text, String? imageUrl) async {
    _posts.add(Post(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      imageUrl: imageUrl,
    ));
  }

  Future<int> getTotalPoints() async {
    return _posts.length * 2;
  }
}
