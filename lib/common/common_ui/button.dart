import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatefulWidget {
  final bool? isSelected;
  final String? text;
  final EdgeInsets? margin;
  final Function? function;

  const ButtonWidget({this.isSelected, this.text, this.margin, this.function, Key? key})
      : super(key: key);

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.function?.call(),
      child: Container(
        height: 59,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        margin: widget.margin,
        decoration: widget.isSelected ?? false
            ? const BoxDecoration(
                color: Colors.grey,
                gradient: LinearGradient(colors: [
                  Color(0xffF1039A),
                  Color(0xff080058),
                ]))
            : const BoxDecoration(color: Colors.grey),
        child: Text(
          widget.text ?? '',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700, fontSize: 15, color: Colors.white),
        ),
      ),
    );
  }
}
