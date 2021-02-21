import 'package:flutter/material.dart';

// The separator for horizontal lists.
class HorizontalListSeparator extends StatelessWidget {
  const HorizontalListSeparator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
    );
  }
}

// The separator for vertical lists.
class VerticalListSeparator extends StatelessWidget {
  const VerticalListSeparator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
    );
  }
}
