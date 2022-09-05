import 'dart:io';

import 'package:demo_palora_app/common/common_ui/button.dart';
import 'package:demo_palora_app/model/image_model.dart';
import 'package:demo_palora_app/pickup_image/item_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/common_ui/app_bar.dart';

class PickUpScreen extends StatefulWidget {
  final bool isSelectMultiple;

  const PickUpScreen({required this.isSelectMultiple, Key? key})
      : super(key: key);

  @override
  State<PickUpScreen> createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  var data = [];
  int _position = 0;
  static int page = 0;
  bool isLoading = false;
  late bool _isSelected;
  late int _currentPosition;
  final List<ImageModel> _listImage = [];
  late final List<int> _listSelected = [];
  final ScrollController _sc = ScrollController();
  static const platform = MethodChannel('demo.get.image');

  @override
  void initState() {
    _currentPosition = -1;
    _isSelected = false;
    _getData();
    super.initState();

    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        if (_position < data.length) {
          _getMoreData(page);
        } else {
          return;
        }
      }
    });
  }

  Future<void> _getData() async {
    try {
      data = await platform.invokeMethod('get_images');
      _getMoreData(page);
      setState(() {});
    } on PlatformException {
      // Unable to open the browser print(e);
    }
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  setSelectRadioTile(int index) {
    setState(() {
      if (_currentPosition > -1) {
        if (_currentPosition != index) {
          _listImage[_currentPosition].isSelected = false;
        }
        _listImage[index].isSelected = !_listImage[index].isSelected!;
      } else {
        _listImage[index].isSelected = true;
      }
      _currentPosition = index;
    });
  }

  setSelectMultipleRadioTile(int index) {
    setState(() {
      if (_listSelected.isNotEmpty) {
        if (_listSelected.any((item) => item == index)) {
          _listSelected.remove(index);
          _listImage[index].isSelected = false;
        } else {
          _listSelected.add(index);
          _listImage[index].isSelected = true;
        }
      } else {
        _listSelected.add(index);
        _listImage[index].isSelected = true;
      }
    });
  }

  void _getMoreData(int index) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      List<ImageModel> tempList = [];
      if (_position < data.length) {
        for (int i = _position; i < _position + 20; i++) {
          if (i < data.length) {
            tempList.add(ImageModel(image: data[i]));
          }
        }
        _position = _position + 20;
      }
      setState(() {
        isLoading = false;
        _listImage.addAll(tempList);
        page++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _isSelected
          ? _buildButton(context)
          : const SizedBox(
              height: 0,
              width: 0,
            ),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            _buildGridView(context),
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
      icon: const Icon(Icons.close),
      colorBorder: const Color(0xff8B8B8B),
      widgetCenter: _buildAppBarCenter(context),
      widgetRight: const Icon(Icons.camera_alt_outlined),
      function: (() {
        if(widget.isSelectMultiple){
          Navigator.pop(context, [['']]);
        }else{
          Navigator.pop(context, ['']);
        }
      }),
    );
  }

  Widget _buildAppBarCenter(BuildContext context) {
    return Row(
      children: const [Text('Gallery'), Icon(Icons.keyboard_arrow_down)],
    );
  }

  Widget _buildGridView(BuildContext context) {
    return Expanded(
        child: GridView.builder(
      addAutomaticKeepAlives: true,
      controller: _sc,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          childAspectRatio: 1,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6),
      itemCount: _listImage.length + 1,
      itemBuilder: (context, index) {
        if (index == _listImage.length) {
          return _buildProgressIndicator();
        } else {
          return ItemImage(
            image: File(_listImage[index].image ?? ''),
            isSelected: _listImage[index].isSelected,
            function: (() {
              setState(() {
                if (widget.isSelectMultiple) {
                  setSelectMultipleRadioTile(index);
                  if (_listSelected.isNotEmpty) {
                    _isSelected = true;
                  } else {
                    _isSelected = false;
                  }
                } else {
                  setSelectRadioTile(index);
                  if (_listImage[_currentPosition].isSelected == true) {
                    _isSelected = true;
                  } else {
                    _isSelected = false;
                  }
                }
              });
            }),
          );
        }
      },
    ));
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return ButtonWidget(
      isSelected: true,
      text: 'Confirm',
      margin: const EdgeInsets.all(20),
      function: () {
        if (widget.isSelectMultiple) {
          Navigator.pop(context, [_getListMultipleImage()]);
        } else {
          Navigator.pop(context, [_listImage[_currentPosition].image]);
        }
      },
    );
  }

  List<String> _getListMultipleImage(){
    List<String> listMultipleImage = [];
    for (var element in _listSelected) {
      listMultipleImage.add(_listImage[element].image ?? '');
    }
    return listMultipleImage;
  }
}
