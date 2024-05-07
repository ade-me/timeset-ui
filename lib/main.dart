import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/screens/auth/onboarding.dart';
import 'package:timeset/screens/home_screen.dart';
import 'package:timeset/state_management/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  final onboardingVal = prefs.getBool("onboarding") ?? false;
  runApp(MyApp(onboarding: onboardingVal));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  const MyApp({super.key, this.onboarding = false});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AuthProvider(),
          ),
        ],
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "TimeSet",
            theme: ThemeData(
              primaryColor: HexColor("#9CBB30"),
              fontFamily: 'pjs',
              scaffoldBackgroundColor: HexColor("#141414"),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                  fontFamily: "pjs-bold",
                  color: Colors.white,
                ),
                bodyMedium: TextStyle(
                  fontFamily: "pjs",
                  color: Colors.white,
                ),
              ),
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: HexColor("#9CBB30"),
                selectionColor: HexColor("#2C2C2C"),
                selectionHandleColor: HexColor("#9CBB30"),
              ),
            ),
            home: Provider.of<AuthProvider>(context).isLoggedin
                ? const HomeScreen()
                : const Onboarding(),
          );
        },
      );
    });
  }
}
