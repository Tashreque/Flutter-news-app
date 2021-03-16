import 'package:flutter/material.dart';
import 'package:my_news/global_variables/global_variables.dart';
import 'package:my_news/local_storage/shared_preferences_handler.dart';
import 'package:my_news/model/news_source.dart';
import 'package:my_news/networking/network_manager.dart';

class OptionsDrawer extends StatefulWidget {
  final void Function(String countryCode) selectedCountry;
  final void Function(String source) selectedSource;
  OptionsDrawer({Key key, this.selectedCountry, this.selectedSource})
      : super(key: key);

  @override
  _OptionsDrawerState createState() => _OptionsDrawerState();
}

class _OptionsDrawerState extends State<OptionsDrawer> {
  String _selectedDropdownValue;
  String _selectedSourceFromDropDown = "Select News Source";
  List<String> _countryList = [];
  List<NewsSource> _newsSources = [];

  final Widget loadingIndicator = Container(
    height: 50,
    child: Center(
      child: CircularProgressIndicator(
        value: null,
        backgroundColor: Colors.white,
        strokeWidth: 5,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    countryCodeDictionary.forEach((key, value) {
      _countryList.add(key);
    });

    // Fetch last selected country from shared preferences/user defaults.
    Future<String> country =
        SharedPreferencesHandler.instance.getlastSelectedCountry();
    country.then((value) {
      _selectedDropdownValue = value;
      getAvailableSources(countryCodeDictionary[value] ?? "us", (sources) {
        _newsSources = sources;
        setState(() {
          print("Obtained news sources from server!");
        });
      });
      setState(() {
        print("retrieved country from sharedPref: " + _selectedDropdownValue);
      });
    });
  }

  // Fetch news sources based on the selected country.
  void getAvailableSources(
      String countryCode, completion(List<NewsSource> sources)) {
    // Fetch news sources based on the selected country.
    print(countryCode);
    Future<List<NewsSource>> sources =
        NetworkManager.instance.getAvailableNewsSources(countryCode);
    sources.then((value) {
      completion(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      hint: Container(
                        child: Center(
                          child: Text(
                            _selectedDropdownValue ?? "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      elevation: 0,
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      items: _countryList.map((each) {
                        return DropdownMenuItem(
                          value: each,
                          child: Container(
                            child: Center(
                              child: Text(
                                each,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        if (_selectedDropdownValue != newValue) {
                          SharedPreferencesHandler.instance
                              .saveCountryToSharedPreference(newValue);
                          _selectedDropdownValue = newValue;
                          _newsSources = [];
                          setState(() {
                            print("Fetching new news source list");
                          });
                          getAvailableSources(countryCodeDictionary[newValue],
                              (sources) {
                            _newsSources = sources;
                            setState(() {
                              print(
                                  "Updated news source list based on country");
                            });
                          });
                          widget.selectedCountry(
                              countryCodeDictionary[_selectedDropdownValue]);
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              _newsSources.length > 0
                  ? Container(
                      color: Colors.white,
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                            hint: Container(
                              child: Center(
                                child: Text(
                                  _selectedSourceFromDropDown ?? "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            elevation: 0,
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            items: _newsSources.map((each) {
                              return DropdownMenuItem(
                                value: each,
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      each.name ?? "",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              final NewsSource newSource = newValue;
                              final String name = newSource.name ?? "";
                              if (name != _selectedSourceFromDropDown) {
                                _selectedSourceFromDropDown = name;
                                setState(() {
                                  print("Updated selected news source");
                                });

                                widget.selectedSource(
                                    _selectedSourceFromDropDown);
                              }
                            },
                          ),
                        ),
                      ),
                    )
                  : this.loadingIndicator,
            ],
          ),
        ),
      ),
    );
  }
}
