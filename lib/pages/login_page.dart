import 'package:edudash_admin/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:edudash_admin/services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  var isPasswordView = true;

  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EduDash',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.normal
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              'E-mail or Phone Number',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextField(
              controller: controllerEmail,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 25),
            Text(
              'Password',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextField(
              controller: controllerPassword,
              onTap: () {
      
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                suffixIcon: GestureDetector(
                  onTapDown: (_) {
                    setState(() {
                      isPasswordView = !isPasswordView;
                    });
                  },
                  child: Icon(isPasswordView ? Icons.remove_red_eye_outlined : Icons.remove_red_eye_sharp),
                )
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              obscureText: isPasswordView,
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () async {
                await Auth().signInWithEmailAndPassword(
                  email: controllerEmail.text,
                  password: controllerPassword.text,
                  context: context
                );
              }, 
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                minimumSize: const Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const SignupPage();
                      }
                    )
                  ), 
                  child: const Text(
                    'Sign-up'
                  )
                ),
                TextButton(
                  onPressed: (){
                
                  }, 
                  child: const Text(
                    'Forgot Password'
                  )
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}