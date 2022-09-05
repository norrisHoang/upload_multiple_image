import 'package:demo_palora_app/model/image_model.dart';
import 'package:equatable/equatable.dart';

abstract class UpLoadEvent extends Equatable {
  const UpLoadEvent();

  @override
  List<Object?> get props => [];
}

class RequestUploadMultipleImage extends UpLoadEvent {
  final List<ImageModel>? listImage;

  const RequestUploadMultipleImage(this.listImage);

  @override
  List<Object?> get props => [listImage];
}