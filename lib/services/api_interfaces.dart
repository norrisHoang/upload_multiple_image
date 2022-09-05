import 'dart:async';

import '../model/image_model.dart';

abstract class ApiInterface {
  Future<void> upLoadMultipleImage(List<ImageModel> listImages, Function(int count, int total, int i, int length) onSendProgress);
}
