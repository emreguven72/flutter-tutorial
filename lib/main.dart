import 'package:firebase_core/firebase_core.dart';
import 'package:firstproject/firebase_options.dart';
import 'package:firstproject/views/login_view.dart';
import 'package:firstproject/views/register_view.dart';
import 'package:firstproject/views/verify_email_view.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
        '/verify-email/': (context) => const VerifyEmailView()
      },
    ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.done: 
              // final user = FirebaseAuth.instance.currentUser;
              // if(user?.emailVerified ?? false) {
              //   return const Text("Done");
              // } else {
              //   return const VerifyEmailView();
              // }
              return const LoginView();
            default: 
              return const CircularProgressIndicator();
          }
        },
      );
  }
}




