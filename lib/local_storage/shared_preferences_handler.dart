import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHandler {
  SharedPreferencesHandler._privateConstructor();
  static final instance = SharedPreferencesHandler._privateConstructor();

  // Retrieve data from UserDefaults (iOS) or SharedPreferences (Android).
  Future<String> getlastSelectedCountry() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final lastSelectedCountry =
        preferences.getString("lastSelectedCountry") ?? "Select Country";
    return lastSelectedCountry;
  }

  // Store selected country to UserDefaults (iOS) or SharedPreferences (Android).
  void saveCountryToSharedPreference(String selectedCountry) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("lastSelectedCountry", selectedCountry);
  }
}
