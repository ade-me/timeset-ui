import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timeset/screens/create_post_screens/create_post_screen.dart';
import 'package:timeset/screens/profile_screens/edit_profile_root.dart';
import 'package:timeset/screens/settings_screens/settings_root.dart';

import '../screens/chat_screens/activities_screen.dart';
import '../screens/chat_screens/chat_screen.dart';
import '../screens/home_screen.dart';
import '../screens/search/search_result_screen.dart';
import '../screens/auth/create_new_password_screen.dart';
import '../screens/auth/fill_profile_screen.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/auth/auth_root.dart';
import '../screens/auth/create_account_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/shop_screens/cart_screen.dart';
import '../screens/shop_screens/check_out_screen.dart';
import '../screens/shop_screens/product_screen.dart';
import '../screens/shop_screens/shop_category_screen.dart';
import '../widgets/inbox_widgets/call_screen.dart';

class CustomPageRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings, cameras) {
    switch (settings.name) {
      case AuthRoot.routeName:
        return _pageTransition(
          child: const AuthRoot(),
          settings: settings,
        );
      case LoginScreen.routeName:
        return _pageTransition(
          child: const LoginScreen(),
          settings: settings,
        );
      case CreateAccountScreen.routeName:
        return _pageTransition(
          child: const CreateAccountScreen(),
          settings: settings,
        );
      case ForgotPasswordScreen.routeName:
        return _pageTransition(
          child: const ForgotPasswordScreen(),
          settings: settings,
        );
      case CreateNewPassword.routeName:
        return _pageTransition(
          child: const CreateNewPassword(),
          settings: settings,
        );
      case FillProfileScreen.routeName:
        return _pageTransition(
          child: const FillProfileScreen(),
          settings: settings,
        );
      case HomeScreen.routeName:
        return _pageTransition(
          child: const HomeScreen(),
          settings: settings,
        );
      case SearchResultScreen.routeName:
        return _pageTransition(
          child: const SearchResultScreen(),
          settings: settings,
        );
      case ShopCategoryScreen.routeName:
        return _pageTransition(
          child: const ShopCategoryScreen(),
          settings: settings,
        );
      case CreatePostScreen.routeName:
        return _pageTransition(
          child: CreatePostScreen(
            cameras: cameras,
          ),
          settings: settings,
        );
      case ProductScreen.routeName:
        return _pageTransition(
          child: const ProductScreen(),
          settings: settings,
        );
      case CartScreen.routeName:
        return _pageTransition(
          child: const CartScreen(),
          settings: settings,
        );
      case CheckOutScreen.routeName:
        return _pageTransition(
          child: const CheckOutScreen(),
          settings: settings,
        );
      case SettingsRoot.routeName:
        return _pageTransition(
          child: const SettingsRoot(),
          settings: settings,
        );
      case EditProfileRoot.routeName:
        return _pageTransition(
          child: const EditProfileRoot(),
          settings: settings,
        );
      case ActivitiesScreen.routeName:
        return _pageTransition(
          child: const ActivitiesScreen(),
          settings: settings,
        );
      case ChatScreen.routeName:
        return _pageTransition(
          child: const ChatScreen(),
          settings: settings,
        );
      case CallScreen.routeName:
        return _pageTransition(
          child: const CallScreen(),
          settings: settings,
        );
      default:
        return null;
    }
  }

  static PageTransition _pageTransition({
    required Widget child,
    required RouteSettings settings,
  }) {
    return PageTransition(
      child: child,
      type: PageTransitionType.rightToLeftWithFade,
      settings: settings,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
    );
  }
}
