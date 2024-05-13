import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'helpers/custom_page_route.dart';
import 'screens/auth/onboarding.dart';
import 'screens/home_screen.dart';
import 'services/shared_pref.dart';
import 'state_management/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPref sharedPref = SharedPref();
  await sharedPref.initSharedPref();

  runApp(MyApp(onboarding: sharedPref.isOnboarding));

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
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
              ),
              primaryColor: HexColor("#9CBB30"),
              fontFamily: 'pjs',
              scaffoldBackgroundColor: HexColor("#141414"),
              textTheme: TextTheme(
                headlineMedium: TextStyle(
                  fontFamily: "pjs-bold",
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
                bodyLarge: const TextStyle(
                  fontFamily: "pjs-bold",
                  color: Colors.white,
                ),
                bodyMedium: const TextStyle(
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
            onGenerateRoute: CustomPageRoute.onGenerateRoute,
          );
        },
      );
    });
  }
}
