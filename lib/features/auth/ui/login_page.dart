import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Login", textAlign: TextAlign.center,)),
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
          margin: EdgeInsetsGeometry.only(top: 15),
          padding: const EdgeInsets.all(16.0),
          transformAlignment: Alignment.center,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(SignInRequested(
                    emailController.text,
                    passwordController.text,
                  ));
                },
                child: const Text("Sign In"),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text("Don't have an account? Sign Up"),
              ),
            ],
          ),

        ),
      ),
    );
  }
}
