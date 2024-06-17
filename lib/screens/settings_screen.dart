import 'package:bread_app/widgets/custom/delete_dialog.dart';
import 'package:bread_app/widgets/custom/sized_box.dart';
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
  Session? currentSession;
  final supabase = Supabase.instance.client;
  @override
  void initState() {
    super.initState();
    currentSession = supabase.auth.currentSession;
  }

  Future<void> _signOut() async {
    try {
      await supabase.auth.signOut();
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

  Future<void> _deleteAccount() async {
    try {
      await supabase.functions.invoke('delete-user');
      await supabase.auth.signOut();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Successfully deleted account'),
          backgroundColor:
              Theme.of(context).snackBarTheme.actionBackgroundColor,
        ));
      }
      setState(() {
        currentSession = null;
      });
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
          const CustomSizedBox(),
          if (currentSession != null) ...[
            ElevatedButton(
              onPressed: _signOut,
              child: const Text('Sign Out'),
            ),
            const CustomSizedBox(),
            TextButton(
              onPressed: () {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => DeleteDialog(
                          onConfirm: () {
                            _deleteAccount();
                            Navigator.pop(context);
                          },
                          text: 'Are you sure you want to delete your account? This action cannot be reversed.',
                        ));
              },
              child: const Text("Delete account"),
            )
          ]
        ],
      ),
    );
  }
}
