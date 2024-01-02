import 'package:e_commerce_flutter/core/binding.dart';
import 'package:e_commerce_flutter/core/dependency.dart';
import 'package:e_commerce_flutter/firebase_options.dart';
import 'package:e_commerce_flutter/src/auth/forgot_password/forgot_password_screen.dart';
import 'package:e_commerce_flutter/src/auth/verify_email/verify_email_view.dart';
import 'package:e_commerce_flutter/src/customerview/view/screen/home_screen/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import 'src/customerview/view/screen/payment_screen/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyCreator.init();
  Stripe.publishableKey = stripePublishableKey;
  await Stripe.instance.applySettings();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        '/verifyemail/': (context) => const VerifyEmailView(),
        '/forgot_password/': (context) => const ForgotPassWordScreen(),
      },
      getPages: Nav.routes,
      initialBinding: DashBoardControllerBinding(),
    ),
  );
}
