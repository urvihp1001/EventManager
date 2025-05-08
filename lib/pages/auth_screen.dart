import 'package:event_management_app/pages/eventlistscreen.dart';
import 'package:event_management_app/providers/auth_provider.dart'; // Import your auth provider
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Import your EventListScreen

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email = '';
  String _password = '';
  bool _isLoading = false;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => _isLoading = true);
    final authProvider = Provider.of<EventAuthProvider>(context, listen: false); // Use the correct provider

    try {
      if (_isLogin) {
        await authProvider.signIn(_email, _password);
      } else {
        await authProvider.signUp(_email, _password);
      }

      // If the user is logged in successfully, navigate to the EventListScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const EventListScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? 'Login' : 'Register')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Email input field
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (val) => _email = val!.trim(),
                  validator: (val) =>
                      val != null && val.contains('@') ? null : 'Invalid email',
                ),
                // Password input field
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onSaved: (val) => _password = val!.trim(),
                  validator: (val) =>
                      val != null && val.length >= 6 ? null : 'Min 6 chars',
                ),
                const SizedBox(height: 20),
                // Loading indicator
                if (_isLoading) const CircularProgressIndicator(),
                // Login/SignUp button
                if (!_isLoading)
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(_isLogin ? 'Login' : 'Register'),
                  ),
                // Toggle between login and sign-up
                TextButton(
                  onPressed: () {
                    setState(() => _isLogin = !_isLogin);
                  },
                  child: Text(_isLogin
                      ? 'Create new account'
                      : 'Already have an account?'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
