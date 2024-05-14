import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'constants/app_colors.dart';
import 'helpers/custom_page_route.dart';
import 'screens/auth/onboarding.dart';
import 'screens/home_screen.dart';
import 'services/shared_pref.dart';
import 'state_management/auth_provider.dart';
import 'state_management/country_provider.dart';

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
          ChangeNotifierProvider(
            create: (context) => CountryProvider(),
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
              primaryColor: AppColors.primary,
              fontFamily: 'pjs',
              scaffoldBackgroundColor: AppColors.scaffoldColor,
              textTheme: TextTheme(
                headlineMedium: TextStyle(
                  fontFamily: "pjs",
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
                bodyLarge: TextStyle(
                  fontFamily: "pjs",
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
                bodyMedium: TextStyle(
                  fontFamily: "pjs",
                  color: Colors.white,
                  fontSize: 12.sp,
                ),
                bodySmall: TextStyle(
                  fontFamily: "pjs",
                  color: Colors.white,
                  fontSize: 10.sp,
                ),
              ),
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: AppColors.primary,
                selectionColor: AppColors.selectionColor,
                selectionHandleColor: AppColors.primary,
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
