import 'package:flutter/material.dart';

import '../../screens/chat_screens/activities_screen.dart';
import '../general_widgets/svg_icon_button.dart';

class InboxAppBar extends StatelessWidget {
  const InboxAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Inbox',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Spacer(),
        SvgIconButton(
          icon: 'activities',
          onPressed: () =>
              Navigator.pushNamed(context, ActivitiesScreen.routeName),
        ),
        const SvgIconButton(
          icon: 'add',
        ),
      ],
    );
  }
}
