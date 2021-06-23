import 'package:audio_service/audio_service.dart';
import 'package:audiobook/services/authentication_service.dart';
import 'package:audiobook/services/database.dart';
import 'package:audiobook/services/appData.dart';
import 'package:audiobook/services/player.dart';
import 'package:audiobook/ui/screens/Onboarding/onboard.dart';
import 'package:audiobook/ui/screens/Onboarding/verify_email.dart';
import 'package:audiobook/ui/screens/appframe.dart';
import 'package:audiobook/ui/screens/Onboarding/login.dart';
import 'package:audiobook/ui/screens/Onboarding/signup.dart';
import 'package:audiobook/ui/screens/Onboarding/splash.dart';
import 'package:audiobook/ui/screens/tabs/genre_single.dart';
import 'package:audiobook/ui/screens/tabs/home%20tabs/genres.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/constants.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:audiobook/utils/route_legend.dart' as routeLegend;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        ChangeNotifierProvider(create: (_) => AppData()),
        ChangeNotifierProvider(create: (_) => Player())
      ],
      child: MaterialApp(
        title: 'AudioBook',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().buildLightTheme(),
        home: Base(),
        routes: {
          SignUp.routeName: (BuildContext context) => SignUp(),
          Login.routeName: (BuildContext context) => Login(),
          AuthenticationWrapper.routeName: (BuildContext context) =>
              AuthenticationWrapper(),
          Splash.routName: (BuildContext context) => Splash(),
          GenreSingle.routeName: (BuildContext context) => GenreSingle(),
          Onboard.routeName: (BuildContext context) => Onboard(),
          VerifyEmail.routeName: (BuildContext context) => VerifyEmail(),
        },
      ),
    );
  }
}

class Base extends StatefulWidget {
  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {
  @override
  void didChangeDependencies() {
    FDatabase().isFirstTime().then((value) {
      if (value)
        Navigator.pushReplacementNamed(context, Onboard.routeName);
      else
        Navigator.pushReplacementNamed(
            context, AuthenticationWrapper.routeName);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Splash();
  }
}

class AuthenticationWrapper extends StatelessWidget {
  static const routeName = "/auth";
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return FutureBuilder(
          future: context.read<AuthenticaitonService>().startUp(firebaseUser),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Splash();
            } else {
              return AppFrame();
            }
          });
    } else {
      return Login();
    }
  }
}
