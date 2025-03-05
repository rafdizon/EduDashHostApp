import 'package:edudash_admin/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:edudash_admin/services/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var isPasswordView = true;
  var isConfPasswordView = true;

  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerRepeatPassword = TextEditingController();
  final TextEditingController controllerUsername = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign-Up',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.normal
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 50, 16, MediaQuery.of(context).viewInsets.bottom + 50),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    SizedBox(height: 25),
                    Text(
                      'Username',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextField(
                      controller: controllerUsername,
                      onTap: () {
                            
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 25),
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
                    SizedBox(height: 25),
                    Text(
                      'Confirm Password',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextField(
                      controller: controllerRepeatPassword,
                      onTap: () {
                            
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        suffixIcon: GestureDetector(
                          onTapDown: (_) {
                            setState(() {
                              isConfPasswordView = !isConfPasswordView;
                            });
                          },
                          child: Icon(isConfPasswordView ? Icons.remove_red_eye_outlined : Icons.remove_red_eye_sharp),
                        )
                      ),
                      style: Theme.of(context).textTheme.bodyMedium,
                      obscureText: isConfPasswordView,
                    ),
                    SizedBox(height: 15),
                    TextButton(
                      onPressed: () async {
                        if(controllerPassword.text == controllerRepeatPassword.text){
                          if (!(controllerEmail.text == null || controllerEmail.text == "") || !(controllerUsername.text == null || controllerUsername.text == "") || !(controllerPassword.text == null || controllerPassword.text == "")) {
                            await Auth().createUserWithEmailAndPassword(
                              email: controllerEmail.text,
                              password: controllerPassword.text,
                              role: "Instructor",
                              username: controllerUsername.text
                            );
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const LoginPage())
                            );
                          }
                          else {
                            Fluttertoast.showToast(
                              msg: "Fill up all the fields",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.SNACKBAR,
                              backgroundColor: Colors.black87,
                              textColor: Colors.white,
                              fontSize: 12,
                            );
                          }
                        }
                        else {
                          Fluttertoast.showToast(
                            msg: "Password does not match!",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.SNACKBAR,
                            backgroundColor: Colors.black87,
                            textColor: Colors.white,
                            fontSize: 12,
                          );
                        }
                        
                      }, 
                      child: Text(
                        'Sign-up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        minimumSize: Size(double.infinity, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        
      ),
    );
  }
}