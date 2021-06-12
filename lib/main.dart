import 'package:cryptfolio/provider_data.dart';
import 'package:cryptfolio/screens/home_screen.dart';
import 'package:cryptfolio/screens/loading_screen.dart';
import 'package:cryptfolio/screens/navigatio_screen.dart';
import 'package:cryptfolio/screens/login_screen.dart';
import 'package:cryptfolio/screens/profile_screen.dart';
import 'package:cryptfolio/screens/signup_screen.dart';
import 'package:cryptfolio/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: LoadingScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          NavigationScreen.id: (context) => NavigationScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
          LoadingScreen.id: (context) => LoadingScreen(),
        },
      ),
    );
  }
}
