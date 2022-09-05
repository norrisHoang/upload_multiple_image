import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderWidget extends StatelessWidget {
  final String? title;
  final double? spaceBetween;
  final double? paddingTop;
  final double? paddingBottom;
  final TextStyle styleTitle;
  final TextStyle styleBody;
  final String? body;

  const HeaderWidget(
      {this.title,
      this.spaceBetween,
      this.paddingTop,
      this.paddingBottom,
      required this.styleTitle,
      required this.styleBody,
      this.body,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 33,
          right: 117,
          top: paddingTop ?? 0,
          bottom: paddingBottom ?? 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title ?? '', style: styleTitle),
          SizedBox(height: spaceBetween ?? 0),
          Text(body ?? '', style: styleBody),
        ],
      ),
    );
  }
}
