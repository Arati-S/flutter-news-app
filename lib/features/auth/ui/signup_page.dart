import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacementNamed(context, '/feed');
          } else if (state is Unauthenticated && state.message != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message!)));
          }
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(SignUpRequested(
                        emailController.text,
                        passwordController.text,
                      ));
                    },
                    child: const Text("Sign Up"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
