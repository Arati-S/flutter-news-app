import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';
import '../bloc/post_state.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PostBloc>().add(LoadPosts());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "The Posts are here",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/profile'),
            icon: const Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return Container(
                  margin: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.arrow_forward_ios_sharp),
                    title: Text(
                      post.text,
                      style: const TextStyle(fontSize: 18),
                    ),
                    subtitle: post.imageUrl != null
                        ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.file(
                        File(post.imageUrl!),
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    )
                        : null,
                  ),
                );
              },
            );
          } else if (state is PostError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/create'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
