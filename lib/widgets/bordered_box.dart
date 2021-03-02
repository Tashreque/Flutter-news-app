import 'package:flutter/material.dart';

class BorderedBox extends StatelessWidget {
  final String stringContent;
  final Color fillColour;
  final Color borderColor;
  const BorderedBox(
      {Key key,
      @required this.stringContent,
      @required this.fillColour,
      @required this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          this.stringContent,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: this.borderColor,
            fontWeight: FontWeight.normal,
            fontSize: 16,
            decoration: TextDecoration.none,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: this.fillColour,
        border: Border.all(
          color: this.borderColor,
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
