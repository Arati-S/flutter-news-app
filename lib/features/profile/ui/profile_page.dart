import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(LoadPoints());

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const CircularProgressIndicator();
            } else if (state is ProfileLoaded) {
              return Text("Total Points: ${state.points}",
                  style: const TextStyle(fontSize: 20));
            }
            return const Text("No data");
          },
        ),
      ),
    );
  }
}
