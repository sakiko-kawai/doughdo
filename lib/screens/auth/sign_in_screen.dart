import 'package:bread_app/screens/auth/sign_up_screen.dart';
import 'package:bread_app/screens/record/record_overview_screen.dart';
import 'package:bread_app/widgets/custom/scaffold.dart';
import 'package:bread_app/widgets/custom/sized_box.dart';
import 'package:bread_app/widgets/custom/title.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _signIn() async {
    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RecordOverviewScreen(),
          ));
    } on AuthException catch (error) {
      if (mounted) {
        SnackBar(
          content: Text(error.message),
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      }
    } catch (error) {
      if (mounted) {
        SnackBar(
          content: const Text('Unexpected error occurred'),
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const CustomTitle(
            text: "Sign In",
          ),
          const Text("Sign in or sign up to record your bakes"),
          const CustomSizedBox(),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const CustomSizedBox(),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          const CustomSizedBox(),
          ElevatedButton(
            onPressed: _signIn,
            child: const Text('Sign In'),
          ),
          const CustomSizedBox(),
          const Text("Don't have an account?"),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                  ));
            },
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}