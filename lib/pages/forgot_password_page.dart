import 'package:flutter/material.dart';
import 'package:edudash_admin/services/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _sendPasswordResetEmail() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Auth().sendPasswordResetEmail(
        email: _emailController.text.trim(),
        context: context,
      );
      Fluttertoast.showToast(
        msg: 'Password reset link sent to your email.', 
        backgroundColor: Theme.of(context).colorScheme.primary,
        textColor: Colors.white
      );
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Error: ${error.toString()}',
        backgroundColor: Theme.of(context).colorScheme.primary,
        textColor: Colors.white
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Forgot Password',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Colors.white
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Enter your email address and we will send you a link to reset your password.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary
                ),
                onPressed: _isLoading ? null : _sendPasswordResetEmail,
                child: _isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text('Reset Password', style: TextStyle(color: Colors.white),),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
