import 'dart:io';

import 'package:flutter/material.dart';

class ItemImage extends StatefulWidget {
  final File? image;
  final bool? isSelected;
  final Function? function;
  const ItemImage({this.image, this.isSelected, this.function, Key? key}) : super(key: key);

  @override
  State<ItemImage> createState() => _ItemImageState();
}

class _ItemImageState extends State<ItemImage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
        onTap: () => widget.function!.call(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.file(
              widget.image ?? File(''),
              width: 121,
              height: 121,
              cacheHeight: 500,
              cacheWidth: 320,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Visibility(
                  visible: widget.isSelected ?? false,
                  child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
            ),
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
