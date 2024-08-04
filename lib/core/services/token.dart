import 'package:shared_preferences/shared_preferences.dart';

class IsInBoarding {
  static SharedPreferences? _sharedToken;
  static init() async {
    _sharedToken = await SharedPreferences.getInstance();
  }

  static siveIsInBoarding({required bool isInBoarding}) {
    _sharedToken!.setBool('inBoarding', isInBoarding);
  }

  static bool? getIsInBoarding() {
    return _sharedToken!.getBool('inBoarding');
  }

  static Future<bool> removeIsInBoarding() {
    return _sharedToken!.remove('inBoarding');
  }
}
