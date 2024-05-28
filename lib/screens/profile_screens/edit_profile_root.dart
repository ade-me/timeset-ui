import 'package:flutter/material.dart';
import 'package:timeset/screens/profile_screens/edit_field_page.dart';
import 'package:timeset/screens/profile_screens/edit_profile_screen.dart';

class EditProfileRoot extends StatefulWidget {
  static const routeName = "/EditProfileScreen";
  const EditProfileRoot({super.key});

  @override
  State<EditProfileRoot> createState() => _EditProfileRootState();
}

class _EditProfileRootState extends State<EditProfileRoot> {
  final pageController = PageController();

  int currentIndex = 0;
  String fieldToUpdate = "";
  String editTitle = "";

  @override
  void dispose() {
    super.dispose();

    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      EditProfileScreen(
        pageController: pageController,
        setter: (data) {
          setState(() {
            fieldToUpdate = data["fieldToUpdate"]!;
            editTitle = data["title"]!;
          });
        },
      ),
      EditFieldPage(
        pageController: pageController,
        editTitle: editTitle,
        fieldToUpdate: fieldToUpdate,
      ),
    ];
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: pages,
        onPageChanged: (index) => setState(() {
          currentIndex = index;
        }),
      ),
    );
  }
}
