import 'package:flutter/material.dart';

import 'single_comment.dart';

class Comments extends StatelessWidget {
  const Comments({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return const SingleComment();
        },
      ),
    );
  }
}
