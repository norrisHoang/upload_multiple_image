import 'package:demo_palora_app/upload_bloc/upload_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc {
  static List<BlocProvider> allBlocs() {
    return [
      BlocProvider<UploadBloc>(
        create: (BuildContext context) => UploadBloc(),
      ),
    ];
  }
}
