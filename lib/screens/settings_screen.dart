import 'package:bread_app/widgets/custom/title.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../widgets/custom/scaffold.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  dynamic currentSession;
  @override
  void initState() {
    super.initState();
    currentSession = Supabase.instance.client.auth.currentSession;
  }

  Future<void> _signOut() async {
    try {
      await Supabase.instance.client.auth.signOut();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Successfully signed out'),
          backgroundColor:
              Theme.of(context).snackBarTheme.actionBackgroundColor,
        ));
      }
      setState(() {
        currentSession = null;
      });
    } on AuthException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.message),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Unexpected error occurred'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const CustomTitle(text: "Settings"),
          if (currentSession != null)
            ElevatedButton(
              onPressed: _signOut,
              child: const Text('Sign Out'),
            )
        ],
      ),
    );
  }
}
