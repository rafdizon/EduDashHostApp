import 'package:edudash_admin/pages/forgot_password_page.dart';
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

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Log In',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/EduDash.png',
                    width: 200,
                    height: 200,
                  )
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                'E-mail',
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
                onPressed: _isLoading ? null : () async {
                  setState(() {
                    _isLoading = true;
                  });
                  
                  await Auth().signInWithEmailAndPassword(
                    email: controllerEmail.text,
                    password: controllerPassword.text,
                    context: context,
                  );
                  
                  setState(() {
                    _isLoading = false;
                  });
                }, 
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  minimumSize: const Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                child: _isLoading 
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text(
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage()
                        )
                      );
                    }, 
                    child: const Text(
                      'Forgot Password'
                    )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}