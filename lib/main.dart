import 'package:audiobook/services/authentication_service.dart';
import 'package:audiobook/services/database.dart';
import 'package:audiobook/services/homedata.dart';
import 'package:audiobook/services/player.dart';
import 'package:audiobook/ui/screens/Onboarding/onboard.dart';
import 'package:audiobook/ui/screens/appframe.dart';
import 'package:audiobook/ui/screens/home.dart';
import 'package:audiobook/ui/screens/login.dart';
import 'package:audiobook/ui/screens/signup.dart';
import 'package:audiobook/ui/screens/splash.dart';
import 'package:audiobook/ui/screens/tabs/genre_single.dart';
import 'package:audiobook/ui/screens/tabs/home%20tabs/genres.dart';
import 'package:audiobook/ui/screens/user_profile.dart';
import 'package:audiobook/utils/appTheme.dart';
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
        ChangeNotifierProvider(create: (_) => HomeData()),
        ChangeNotifierProvider(create: (_) => Player())
      ],
      child: MaterialApp(
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        title: 'AudioBook',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().buildLightTheme(),
        //darkTheme: AppTheme().buildDarkTheme(),
        home: Base(),
        //onGenerateRoute: routeLegend.generateRoute,
        routes: {
          SignUp.routeName: (BuildContext context) => SignUp(),
          Login.routeName: (BuildContext context) => Login(),
          Home.routeName: (BuildContext context) => Home(),
          UserProfile.routeName: (BuildContext context) => UserProfile(),
          AuthenticationWrapper.routeName: (BuildContext context) =>
              AuthenticationWrapper(),
          Splash.routName: (BuildContext context) => Splash(),
          GenreSingle.routeName: (BuildContext context) => GenreSingle(),
        },
      ),
    );
  }
}

class Base extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return
        //AppFrame();
        FutureBuilder(
      future: FDatabase().isFirstTime(),
      builder: (BuildContext ctx, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Splash();
        } else {
          if (snapshot.data) {
            return Onboard();
          } else {
            return AuthenticationWrapper();
          }
        }
      },
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  static const routeName = "/auth";
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
