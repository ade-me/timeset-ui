import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  bool _isOnboarding = false;
  bool get isOnboarding => _isOnboarding;

  Future<SharedPreferences> getSharedInstance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences;
  }

  Future<void> initSharedPref() async {
    await getSharedInstance();
    getOnboardingStatus();
  }

  void getOnboardingStatus() async {
    SharedPreferences sharedPref = await getSharedInstance();

    _isOnboarding = sharedPref.getBool("onboarding") ?? false;
  }
}
