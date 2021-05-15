import 'package:audiobook/services/authentication_service.dart';
import 'package:audiobook/services/google_signin_service.dart';
import 'package:audiobook/ui/screens/home.dart';
import 'package:audiobook/ui/screens/login.dart';
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

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticaitonService>(
          create: (_) => AuthenticaitonService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticaitonService>().authStateChanges,
          initialData: null,
        ),
        // Provider<GoogleSignInService>(
        //   create: (_) => GoogleSignInService(),
        // ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return Home();
    }
    return Login();
  }
}
