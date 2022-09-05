import 'dart:async';
import 'package:equatable/equatable.dart';

abstract class UploadState extends Equatable {
  const UploadState();

  @override
  List<Object?> get props => [];
}

class UploadInit extends UploadState {
  const UploadInit();
}

class UploadMultipleImageLoading extends UploadState {}

class SendStreamController extends UploadState {
  StreamController controller;

  SendStreamController(this.controller);

  @override
  List<Object?> get props => [controller];
}

class UploadMultipleImageLoaded extends UploadState {
  final int result;

  const UploadMultipleImageLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

class UploadMultipleImageError extends UploadState {
  final String? message;

  const UploadMultipleImageError(this.message);

  @override
  List<Object?> get props => [message];
}
