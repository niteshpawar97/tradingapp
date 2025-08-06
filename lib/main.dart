import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:alevet_market/login/loginscreen.dart';
import 'package:alevet_market/login/registration.dart';
import 'package:alevet_market/profile/BalanceScreen.dart';
import 'package:alevet_market/splash/splash.dart';
import 'package:alevet_market/Screen/Home.dart';
import 'widgets/connectivity_wrapper.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          
          home: ConnectivityWrapper(
            child: SplashScreen(),
          ),
          routes: {
            '/login': (context) => ConnectivityWrapper(child: const LoginScreen()),
            '/register': (context) => ConnectivityWrapper(child: const RegisterScreen()),
            '/home': (context) => ConnectivityWrapper(child: const HomeScreen()),
            '/balance': (context) => ConnectivityWrapper(child: BalanceScreen()),


          },
        );
      },
    );
  }
}