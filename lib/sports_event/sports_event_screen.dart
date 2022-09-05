import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:demo_palora_app/common/common_ui/button.dart';
import 'package:demo_palora_app/model/image_model.dart';
import 'package:demo_palora_app/pickup_image/pickup_screen.dart';
import 'package:demo_palora_app/upload_bloc/upload_bloc.dart';
import 'package:demo_palora_app/upload_bloc/upload_event.dart';
import 'package:demo_palora_app/upload_bloc/upload_state.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/common_ui/app_bar.dart';
import '../common/common_ui/header.dart';

class SportsEventScreen extends StatefulWidget {
  const SportsEventScreen({Key? key}) : super(key: key);

  @override
  State<SportsEventScreen> createState() => _SportsEventScreenState();
}

class _SportsEventScreenState extends State<SportsEventScreen> {
  List<List<String>> _result = [];
  final List<ImageModel> _listMultipleImage = [];
  double valueIndicator = 0;
  int valueText = 0;
  List<double?> listValue = [];
  double percent = 0;

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    _result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PickUpScreen(isSelectMultiple: true),
      ),
    );
    setState(() {
      List<String> listData = _result[0];
      for (var data in listData) {
        ImageModel model = ImageModel(image: _getNameImage(data), path: data);
        _listMultipleImage.add(model);
        listValue.add(0);
      }
      // if (_result[0].contains('')) {
      //   print(_result[0]);
      // } else {
      //   print(_result[0]);
      // }
    });
  }

  String _getNameImage(String data) {
    String name = data.split('/').last;
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadBloc, UploadState>(
        builder: (context, state) => _buildUI(context),
        listener: (context, state) {
          if (state is UploadMultipleImageLoading) {
            log('loading...');
          } else if (state is UploadMultipleImageLoaded) {
            log('Success...');
            setState(() {});
          } else if (state is UploadMultipleImageError) {
            log('message Error: ${state.message}');
          } else if (state is SendStreamController) {
            // Dùng stream vừa được bloc gửi ra để lấy list data ở bloc
            state.controller.stream.listen((event) {
              listValue = event;
              log('data: $event');
              setState(() {});
            });
          }
        });
  }

  Widget _buildUI(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _buildAppBar(context),
            _buildHeaderTop(context),
            _buildTextFieldTitle(context),
            const SizedBox(height: 14),
            _buildTextFieldPostCaption(context),
            const SizedBox(height: 34),
            const Divider(
                thickness: 1,
                color: Color(0xffD4D4D4),
                indent: 38,
                endIndent: 38),
            _buildHeaderBottom(context),
            _buildButtonUploadPhoto(context),
            _buildListSelectedImage(context),
            _buildButton(context)
          ]),
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
              text: '1',
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black)),
          TextSpan(
              text: ' of 4',
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff8B8B8B))),
        ],
      ),
    );
  }

  Widget _buildTextFieldTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(children: [
              Text(
                'Sports Event Title',
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(
                width: 1,
              ),
              Text(
                '*',
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.red),
              ),
            ]),
          ),
          const SizedBox(height: 5),
          TextFormField(
            maxLines: 1,
            style: GoogleFonts.poppins(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
            decoration: const InputDecoration(
              fillColor: Colors.white,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff46016A), width: 2)),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Color(0xffA3A3A3),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffA3A3A3))),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldPostCaption(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              'Post Caption',
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: 200,
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              decoration: const InputDecoration(
                fillColor: Colors.white,
                contentPadding: EdgeInsets.only(bottom: 1, left: 16, right: 12),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                disabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderTop(BuildContext context) {
    return HeaderWidget(
        title: 'Sports Event',
        body: 'What would you want to name your sports event?',
        spaceBetween: 11,
        paddingTop: 31,
        paddingBottom: 28,
        styleTitle: GoogleFonts.roadRage(
            fontWeight: FontWeight.w400, fontSize: 50, color: Colors.black),
        styleBody: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: const Color(0xff5E5E5E)));
  }

  Widget _buildHeaderBottom(BuildContext context) {
    return HeaderWidget(
        title: 'Upload Photos',
        body: 'Share photos about your sports event',
        spaceBetween: 11,
        paddingTop: 20,
        paddingBottom: 28,
        styleTitle: GoogleFonts.roadRage(
            fontWeight: FontWeight.w400, fontSize: 30, color: Colors.black),
        styleBody: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: const Color(0xff5E5E5E)));
  }

  Widget _buildButtonUploadPhoto(BuildContext context) {
    return Container(
      height: 59,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 38, right: 38, bottom: 21),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(46)),
      child: InkWell(
        onTap: () {
          _navigateAndDisplaySelection(context);
        },
        borderRadius: BorderRadius.circular(46),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(46),
          dashPattern: const [3, 3],
          color: const Color(0xffD4D4D4),
          strokeWidth: 2,
          child: Container(
            height: 59,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(46)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.broken_image_outlined,
                  size: 14,
                  color: Color(0xffF1039A),
                ),
                // SvgPicture.asset('assets/icons/ic_picture.svg',
                //     width: 10, height: 10, color: Colors.red),
                const SizedBox(width: 6),
                ShaderMask(
                  shaderCallback: (Rect bounds) =>
                      const LinearGradient(colors: [
                    Color(0xffF1039A),
                    Color(0xff080058),
                  ]).createShader(bounds),
                  child: Text(
                    'Upload Photos',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListSelectedImage(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildItemImage(context, _listMultipleImage[index], index);
      },
      shrinkWrap: true,
      itemCount: _listMultipleImage.length,
    );
  }

  Widget _buildItemImage(BuildContext context, ImageModel? data, int index) {
    return Container(
      height: 64,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 38, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xffF9F9F9),
        borderRadius: BorderRadius.circular(38),
      ),
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 64,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(38),
              child: LinearProgressIndicator(
                value: listValue[index] ?? 0,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Color(0xffF2F2F2)),
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 19, right: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                        width: 32,
                        height: 32,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.file(
                          File(data?.path ?? ''),
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data?.image ?? '',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Colors.black)),
                        Text('${((listValue[index] ?? 0) * 100).toInt().toString()}%',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: const Color(0xffA3A3A3))),
                      ],
                    )
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        _listMultipleImage.remove(data);
                      });
                    },
                    child: const Icon(
                      Icons.close,
                      size: 18,
                      color: Colors.red,
                    ))
                // SvgPicture.asset(
                //   'assets/icons/ic_close.svg',
                //   color: Colors.red,
                //   width: 12,
                //   height: 12,
                // )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return ButtonWidget(
      isSelected: true,
      text: 'Next',
      margin: const EdgeInsets.only(left: 38, right: 38, top: 33, bottom: 54),
      function: () {
        //Truyền vào bloc 1 event upload nhiều ảnh, tham số truyền vào là list ảnh
        context
            .read<UploadBloc>()
            .add(RequestUploadMultipleImage(_listMultipleImage));
      },
    );
  }
}
