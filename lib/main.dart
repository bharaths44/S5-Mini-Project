import 'package:e_commerce_flutter/firebase_options.dart';
import 'package:e_commerce_flutter/src/controller/product_controller.dart';
import 'package:e_commerce_flutter/src/view/screen/auth/forgot_password/forgot_password_screen.dart';
import 'package:e_commerce_flutter/src/view/screen/auth/login/login_screen.dart';
import 'package:e_commerce_flutter/src/view/screen/auth/register/register_screen.dart';
import 'package:e_commerce_flutter/src/view/screen/home_screen/home_screen.dart';
import 'package:e_commerce_flutter/src/view/screen/auth/verify_email/verify_email_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(ProductController());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
        useMaterial3: true,
      ),
      home: HomeScreen(),
      routes: {
        '/login/': (context) => LoginScreen(),
        '/register/': (context) => const RegisterScreen(),
        '/home/': (context) => HomeScreen(),
        '/verifyemail/': (context) => VerifyEmailView(),
        '/forgot_password/': (context) => const ForgotPassWordScreen(),
      },
    ),
  );
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
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                // Display the message and redirect to login screen
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login/', (route) => false);
                });
                return const Scaffold(
                  body: Center(child: Text("Email is verified")),
                );
              } else {
                return VerifyEmailView();
              }
            } else {
              return LoginScreen();
            }
          default:
            return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}
