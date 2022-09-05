import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget {
  final double height;
  final double width;
  final double paddingAppbar;
  final double widthBorder;
  final Color? colorBorder;
  final Color? color;
  final Widget? icon;
  final Widget? widgetCenter;
  final Widget? widgetRight;
  final Function? function;

  const AppBarWidget(
      {this.color,
      required this.height,
      required this.width,
      this.icon,
      required this.paddingAppbar,
      required this.widthBorder,
      this.colorBorder,
      this.widgetCenter,
      this.widgetRight,
      this.function,
      Key? key})
      : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      padding: EdgeInsets.symmetric(horizontal: widget.paddingAppbar),
      decoration: BoxDecoration(
          color: widget.color ?? Colors.white,
          border: Border.all(
              color: widget.colorBorder ?? Colors.white,
              width: widget.widthBorder)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () => widget.function?.call(),
              child: Container(child: widget.icon ?? Container())),
          widget.widgetCenter ?? Container(),
          widget.widgetRight ?? Container()
        ],
      ),
    );
  }
}
