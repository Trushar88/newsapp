import 'package:flutter/material.dart';

// content body widget
// Use this widget to set same padding in every screens
class ContentPadding extends StatelessWidget {
  final Widget child;

  const ContentPadding({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(child: child),
    );
  }
}
