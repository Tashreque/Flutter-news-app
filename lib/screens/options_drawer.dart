import 'package:flutter/material.dart';
import 'package:my_news/global_variables/global_variables.dart';
import 'package:my_news/model/news_source.dart';
import 'package:my_news/networking/network_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OptionsDrawer extends StatefulWidget {
  final void Function(String countryCode) selectedCountry;
  OptionsDrawer({Key key, this.selectedCountry}) : super(key: key);

  @override
  _OptionsDrawerState createState() => _OptionsDrawerState();
}

class _OptionsDrawerState extends State<OptionsDrawer> {
  String _selectedDropdownValue;
  List<String> _countryList = [];
  Future<List<NewsSource>> newsSources;
  @override
  void initState() {
    super.initState();
    countryCodeDictionary.forEach((key, value) {
      _countryList.add(key);
    });

    // Fetch last selected country from shared preferences/user defaults.
    Future<String> country = getlastSelectedCountry();
    country.then((value) {
      _selectedDropdownValue = value;
      getAvailableSources(countryCodeDictionary[value] ?? "us");
      setState(() {
        print("retrieved: " + _selectedDropdownValue);
      });
    });
  }

  // Store data to UserDefaults (iOS) or SharedPreferences (Android).
  void saveToSharedPreference(String selectedCountry) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("lastSelectedCountry", selectedCountry);
  }

  // Retrieve data from UserDefaults (iOS) or SharedPreferences (Android).
  Future<String> getlastSelectedCountry() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final lastSelectedCountry =
        preferences.getString("lastSelectedCountry") ?? "Select Country";
    return lastSelectedCountry;
  }

  // Fetch news sources based on the selected country.
  void getAvailableSources(String countryCode) {
    // Fetch news sources based on the selected country.
    print(countryCode);
    newsSources = NetworkManager.instance.getAvailableNewsSources(countryCode);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: Column(
            children: [
              Container(
                color: Colors.blueAccent,
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      hint: Container(
                        child: Center(
                          child: Text(
                            _selectedDropdownValue,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      elevation: 0,
                      isExpanded: true,
                      dropdownColor: Colors.blueAccent,
                      items: _countryList.map((each) {
                        return DropdownMenuItem(
                          value: each,
                          child: Container(
                            child: Center(
                              child: Text(
                                each,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          if (_selectedDropdownValue != newValue) {
                            saveToSharedPreference(newValue);
                            _selectedDropdownValue = newValue;
                            getAvailableSources(
                                countryCodeDictionary[newValue]);
                            widget.selectedCountry(
                                countryCodeDictionary[_selectedDropdownValue]);
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                color: Colors.blueAccent,
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      hint: Container(
                        child: Center(
                          child: Text(
                            _selectedDropdownValue,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      elevation: 0,
                      isExpanded: true,
                      dropdownColor: Colors.blueAccent,
                      items: _countryList.map((each) {
                        return DropdownMenuItem(
                          value: each,
                          child: Container(
                            child: Center(
                              child: Text(
                                each,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          if (_selectedDropdownValue != newValue) {
                            saveToSharedPreference(newValue);
                            _selectedDropdownValue = newValue;
                            getAvailableSources(
                                countryCodeDictionary[newValue]);
                            widget.selectedCountry(
                                countryCodeDictionary[_selectedDropdownValue]);
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
