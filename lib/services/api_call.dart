import 'dart:async';
import 'package:dio/dio.dart';
import '../model/image_model.dart';
import 'api_constants.dart';
import 'api_interfaces.dart';

class ApiClient extends ApiInterface {

  @override
  Future<void> upLoadMultipleImage(List<ImageModel> listImages, Function(int count, int total, int i, int length) onSendProgress) async {
    var dio = Dio();
    List<Future> futures = [];

    //Set header
    dio.options.headers = {
      "Content-Type": "multipart/form-data",
      "Authorization": "Bearer $accessToken"
    };

    //Vòng lặp for để upload các ảnh
    for (int i = 0 ; i < listImages.length; i++) {
      //Setup data để gửi
      var formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(listImages[i].path!, filename: listImages[i].image),
      });
      //Sử dụng list future để upload nhiều ảnh
      futures.add(dio.post(baseUrl,
          data: formData,
          onSendProgress: (int count, int total) {
            onSendProgress(count, total, i, listImages.length);
          }));
    }

    //đợi khi nào list future upload hết
    final response = await Future.wait(futures);
    print(response);
  }
}
