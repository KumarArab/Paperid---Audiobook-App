import 'package:audiobook/services/authentication_service.dart';
import 'package:audiobook/services/database.dart';
import 'package:audiobook/ui/screens/home.dart';
import 'package:audiobook/ui/screens/login.dart';
import 'package:audiobook/ui/screens/signup.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticaitonService>(
          create: (_) => AuthenticaitonService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticaitonService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        title: 'AudioBook',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().buildLightTheme(),
        //darkTheme: AppTheme().buildDarkTheme(),
        home: AuthenticationWrapper(),
        routes: {
          SignUp.routeName: (BuildContext context) => SignUp(),
          Login.routeName: (BuildContext context) => Login(),
          Home.routeName: (BuildContext context) => Home(),
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  void checkUser(BuildContext context, User firebaseUser) {
    context
        .read<AuthenticaitonService>()
        .startUp(firebaseUser)
        .then((value) => Home());
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return FutureBuilder(
          future: context.read<AuthenticaitonService>().startUp(firebaseUser),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(
                  child: Icon(Icons.ac_unit),
                ),
              );
            } else {
              return Home();
            }
          });
    } else {
      return Login();
    }
  }
}
