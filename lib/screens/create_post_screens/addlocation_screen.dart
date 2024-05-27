import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:timeset/helpers/location_helper.dart';

import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/general_app_padding.dart';
import '../../widgets/create_post_widgets/location_select.dart';

class AddlocationScreen extends StatefulWidget {
  const AddlocationScreen({
    super.key,
    required this.pageController,
    this.onLocationSelected,
  });
  final PageController pageController;
  final Function(Map<String, dynamic>)? onLocationSelected;

  @override
  State<AddlocationScreen> createState() => _AddlocationScreenState();
}

class _AddlocationScreenState extends State<AddlocationScreen> {
  final searchTextController = TextEditingController();

  final searchFocusNode = FocusNode();

  List<String> _predictions = [];

  @override
  void dispose() {
    super.dispose();

    searchTextController.dispose();

    searchFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (willPop) {
        widget.pageController.jumpToPage(2);
      },
      child: Scaffold(
        body: SafeArea(
          child: GeneralAppPadding(
            verticalPadding: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarWithBackButton(
                  title: "Add location",
                  hasCustomFunction: true,
                  function: () {
                    widget.pageController.jumpToPage(
                      2,
                    );
                  },
                ),
                SizedBox(
                  height: 1.w,
                ),
                CustomTextField(
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _fetchPredictions(value);
                    } else {
                      setState(() {
                        _predictions.clear();
                      });
                    }
                  },
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  controller: searchTextController,
                  focusNode: searchFocusNode,
                  iconName: 'search_inactive',
                  hintText: 'Search for a location',
                  iconColor: HexColor("#9CBB30"),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _predictions.length,
                    itemBuilder: (context, index) {
                      return LocationSelect(
                        onTap: () async {
                          List<String> longLat =
                              await LocationHelper.getLatLngFromAddress(
                            _predictions[index],
                          );
                          widget.onLocationSelected!({
                            "description": _predictions[index],
                            "longLat": longLat
                          });
                          widget.pageController.jumpToPage(
                            2,
                          );
                        },
                        title: _predictions[index],
                        address: "54, Pine street, nigga avenue",
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _fetchPredictions(String input) async {
    const apiKey = 'AIzaSyCYjFbWXnmgR3AvQ67IGNXHiq51TbQAhzE';
    const baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';

    final response =
        await http.get(Uri.parse('$baseURL?input=$input&key=$apiKey'));

    if (response.statusCode == 200) {
      final predictions = json.decode(response.body)['predictions'];
      List<String> places = [];
      for (var prediction in predictions) {
        places.add(prediction['description']);
      }
      setState(() {
        _predictions = places;
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }
}
