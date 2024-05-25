import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timeset/state_management/post_provider.dart';

import 'constants/app_colors.dart';
import 'helpers/custom_page_route.dart';
import 'screens/auth/onboarding.dart';
import 'screens/home_screen.dart';
import 'state_management/shared_pref.dart';
import 'state_management/auth_provider.dart';
import 'state_management/country_provider.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPref sharedPref = SharedPref();
  await sharedPref.initSharedPref();
  final cameras = await availableCameras();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.cameras});
  final List<CameraDescription> cameras;

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
          ChangeNotifierProvider(
            create: (context) => SharedPref(),
          ),
          ChangeNotifierProvider(
            create: (context) => PostProvider(),
          ),
        ],
        builder: (context, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
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
            home: !Provider.of<AuthProvider>(context).isLoggedIn
                ? const HomeScreen()
                : const Onboarding(),
            onGenerateRoute: (settings) =>
                CustomPageRoute.onGenerateRoute(settings, cameras),
          );
        },
      );
    });
  }
}
