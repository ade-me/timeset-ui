import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/general_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/general_app_padding.dart';
import '../../widgets/inbox_widgets/inbox_app_bar.dart';
import '../../widgets/inbox_widgets/message_tile.dart';
import '../../widgets/inbox_widgets/recently_inbox_tile.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 1.h);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sizedBox,
          const GeneralAppPadding(
            child: InboxAppBar(),
          ),
          sizedBox,
          GeneralAppPadding(
            child: SearchTextField(
              controller: searchController,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizedBox,
                  sizedBox,
                  sizedBox,
                  const GeneralAppPadding(
                    child: Text('Recently'),
                  ),
                  sizedBox,
                  sizedBox,
                  SizedBox(
                    height: 10.h,
                    width: 100.w,
                    child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (ctx, index) => RecentlyInboxTile(
                        index: index,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  const GeneralAppPadding(
                    child: Text('Messages'),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (ctx, index) => MessagesTile(
                      index: index,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
