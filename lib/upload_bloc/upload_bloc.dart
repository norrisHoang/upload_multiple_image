import 'dart:async';

import 'package:demo_palora_app/services/api_call.dart';
import 'package:demo_palora_app/upload_bloc/upload_event.dart';
import 'package:demo_palora_app/upload_bloc/upload_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadBloc extends Bloc<UpLoadEvent, UploadState> {
  StreamController<List<double>> progressStreamController =
      StreamController<List<double>>.broadcast();

  UploadBloc() : super(const UploadInit()) {
    on<RequestUploadMultipleImage>(
        (event, emit) => _handleUploadMultipleImage(emit, event));
  }

  _handleUploadMultipleImage(
    Emitter emit,
    RequestUploadMultipleImage event,
  ) async {
    emit(UploadMultipleImageLoading());
    try {
      int countT = 0;
      int totalT = 0;
      List<double> listData = [];

      //Vòng lặp để lấy length cho list data
      for (var element in event.listImage!) {
        listData.add(0);
      }

      //gọi api upload, sẽ trả về call back là (count, total, index, length)
      final result = await ApiClient().upLoadMultipleImage(
        event.listImage ?? [],
        (count, total, index, length) {
          countT = count;
          totalT = total;
          double data = (countT * 100) / totalT;  // xử lý để gán cho UI
          double percent = data / 100;    // xử lý để gán cho UI

          listData[index] = percent;
          progressStreamController.sink.add(listData);    // gửi list data đã đc xử lý vào luồng stream
          emit(SendStreamController(progressStreamController));   // gửi StreamController ra UI để lắng nghe list data
        },
      );
      // emit(UploadMultipleImageLoaded(result));
    } catch (e) {
      emit(UploadMultipleImageError(e.toString()));
    }
  }
}
