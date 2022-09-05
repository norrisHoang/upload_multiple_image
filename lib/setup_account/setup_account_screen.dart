import 'dart:io';

import 'package:demo_palora_app/common/common_ui/app_bar.dart';
import 'package:demo_palora_app/common/common_ui/header.dart';
import 'package:demo_palora_app/pickup_image/pickup_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/common_ui/button.dart';

class SetupAccountScreen extends StatefulWidget {
  const SetupAccountScreen({Key? key}) : super(key: key);

  @override
  State<SetupAccountScreen> createState() => _SetupAccountScreenState();
}

class _SetupAccountScreenState extends State<SetupAccountScreen> {
  late bool _isSelected = false;
  List<String?> _result = [];

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    _result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PickUpScreen(isSelectMultiple: false),
      ),
    );
    setState(() {
      if (_result.contains('')) {
        _isSelected = false;
      } else {
        _isSelected = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _buildAppBar(context),
              _buildHeader(context),
              _buildAvatar(context),
            ]),
            _buildButton(context)
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBarWidget(
      width: double.infinity,
      height: 45,
      paddingAppbar: 33,
      widthBorder: 0.5,
      color: Colors.white,
      icon: const Icon(Icons.arrow_back_ios),
      colorBorder: const Color(0xff8B8B8B),
      widgetRight: _buildAppBarRight(context),
      function: (() {
        Navigator.pop(context);
      }),
    );
  }

  Widget _buildAppBarRight(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: 'Step ',
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff8B8B8B))),
          TextSpan(
              text: '2',
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black)),
          TextSpan(
              text: ' of 3',
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff8B8B8B))),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return HeaderWidget(
        title: 'Setup Account',
        body: 'Set your profile photo',
        spaceBetween: 11,
        paddingTop: 33,
        paddingBottom: 33,
        styleTitle: GoogleFonts.roadRage(
            fontWeight: FontWeight.w400, fontSize: 50, color: Colors.black),
        styleBody: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Color(0xff5E5E5E)));
  }

  Widget _buildAvatar(BuildContext context) {
    return Center(
      child: DottedBorder(
          borderType: BorderType.Circle,
          padding: const EdgeInsets.all(13),
          color: Colors.grey.withOpacity(0.4),
          strokeWidth: 3,
          dashPattern: const [7, 6],
          child: _isSelected
              ? _buildSelectedAvt(context)
              : _buildDefaultAvt(context)),
    );
  }

  Widget _buildDefaultAvt(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigateAndDisplaySelection(context);
      },
      child: Container(
          height: 188,
          width: 188,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Color(0xffF6F6F6),
              borderRadius: BorderRadius.all(Radius.circular(100))),
          child: const Icon(
            Icons.camera_alt_outlined,
            color: Colors.grey,
            size: 59,
          )),
    );
  }

  Widget _buildSelectedAvt(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 188,
          height: 188,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
          child: Image.file(
            File(_result[0] ?? ''),
            fit: BoxFit.cover,
          ),
        ),
        Visibility(
          visible: true,
          child: Positioned(
              bottom: -10,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  _navigateAndDisplaySelection(context);
                },
                child: Card(
                  elevation: 1,
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const SizedBox(
                    height: 49,
                    width: 49,
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.grey,
                      size: 25,
                    ),
                  ),
                ),
              )),
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    return ButtonWidget(
      isSelected: _isSelected,
      text: 'Next',
      margin: const EdgeInsets.only(left: 38, right: 38, bottom: 28),
      function: () {},
    );
  }
}
