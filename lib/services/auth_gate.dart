import 'package:edudash_admin/pages/dashboard_page.dart';
import 'package:edudash_admin/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:edudash_admin/services/auth.dart';

class Provider extends InheritedWidget {
  final Auth auth;
  Provider({
    Key? key,
    required Widget child,
    required this.auth
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget){
    return true;
  }

  static Provider? of(BuildContext context) => (context.dependOnInheritedWidgetOfExactType<Provider>());
}
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of(context)!.auth;

    return StreamBuilder(
      stream: auth.onAuthStateChange, 
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        final bool signedIn = snapshot.hasData;
        return signedIn ? DashboardPage() : LoginPage();
      }
    );
  }
}