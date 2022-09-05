import 'package:demo_palora_app/setup_account/setup_account_screen.dart';
import 'package:demo_palora_app/sports_event/sports_event_screen.dart';
import 'package:demo_palora_app/upload_bloc/main_bloc.dart';
import 'package:demo_palora_app/upload_bloc/upload_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double widthScreen;
  late double heightScreen;

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    heightScreen = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
        providers: MainBloc.allBlocs(), child: _buildUI(context));
  }

  Widget _buildUI(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildButton(
                  context, 'Set Avatar', const SetupAccountScreen()),
              _buildButton(context, 'Upload Multiple Images To Sever', const SportsEventScreen()),
              // _buildButton(context, 'Path Provider',
              //     PathProviderScreen(widthScreen, heightScreen)),
              // _buildButton(context, 'AboutDialog',
              //     AboutDialogScreen(widthScreen, heightScreen)),
              // _buildButton(context, 'CheckboxListTile',
              //     CheckboxListTileScreen(widthScreen, heightScreen)),
              // _buildButton(context, 'ShaderMask',
              //     ShaderMaskScreen(widthScreen, heightScreen)),
              // _buildButton(context, 'ListWheelScrollView',
              //     ListWheelScrollViewScreen(widthScreen, heightScreen)),
              // _buildButton(context, 'SnackBar',
              //     SnackBarScreen(widthScreen, heightScreen)),
              // _buildButton(
              //     context, 'Drawer', DrawerScreen(widthScreen, heightScreen)),
              // _buildButton(context, 'TabBar', const TabBarScreen()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String text, StatefulWidget screen) {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider(
              create: (_) {
                return UploadBloc();
              },
              child: screen),
          ),
        ),
        child: Container(
          width: widthScreen * 0.3,
          height: heightScreen * 0.1,
          margin: const EdgeInsets.only(top: 20),
          alignment: Alignment.center,
          color: Colors.blue,
          child: Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
