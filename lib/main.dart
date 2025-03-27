import 'package:edudash_admin/services/auth.dart';
import 'package:edudash_admin/services/auth_gate.dart';
import 'package:edudash_admin/services/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EduDash Host App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 0, 24, 51),
            primary: const Color.fromARGB(255, 0, 24, 51),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(
              fontSize: 32,
            ),
            titleSmall: TextStyle(
              fontSize: 18,
              fontFamily: "DePixel"
            ),
            bodyLarge: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
            bodyMedium: TextStyle(
              fontSize: 14,
            ),
            bodySmall: TextStyle(
              fontSize: 12
            )
          ),
          useMaterial3: true,
        ),
        home: const AuthGate(),
      ),
    );
  }
}