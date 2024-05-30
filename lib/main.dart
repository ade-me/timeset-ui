import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../state_management/post_provider.dart';
import 'constants/app_colors.dart';
import 'helpers/custom_page_route.dart';
import 'screens/auth/onboarding.dart';
import 'screens/home_screen.dart';
import 'state_management/shared_pref.dart';
import 'state_management/auth_provider.dart';
import 'state_management/country_provider.dart';
import 'firebase_options.dart';
import 'state_management/user_provider.dart';

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
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF000000),
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: null,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  ));

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
          ChangeNotifierProvider(
            create: (context) => UserProvider(),
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
              splashColor: Colors.white10,
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
