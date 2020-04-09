import 'package:floating_menu/floating_menu.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(),
      floatingActionButton: FloatingMenu(
        isMainButton: true,
        mainButtonColor: Colors.red,
        mainButtonIcon: Icons.file_upload,
        mainButtonShape: BoxShape.circle,
        floatingType: FloatingType.RightCurve,
        floatingButtonShape: BoxShape.circle,
        floatingButtons: [
          FloatingButtonModel(
            locationDegree: 270,
            locationDistance: 60,
            shape: BoxShape.circle,
            color: Colors.greenAccent,
            label: "Audio",
            icon: Icons.audiotrack,
            size: Size(50, 50),
            onPress: () {},
          ),
          FloatingButtonModel(
            locationDegree: 270,
            locationDistance: 130,
            shape: BoxShape.circle,
            color: Colors.yellowAccent,
            label: "File",
            icon: Icons.insert_drive_file,
            size: Size(50, 50),
            onPress: () {},
          ),
          FloatingButtonModel(
            locationDegree: 270,
            locationDistance: 190,
            shape: BoxShape.circle,
            color: Colors.purpleAccent,
            label: "Image",
            icon: Icons.image,
            size: Size(50, 50),
            onPress: () {},
          ),
          FloatingButtonModel(
            locationDegree: 270,
            locationDistance: 250,
            shape: BoxShape.circle,
            color: Colors.orangeAccent,
            label: "Video",
            icon: Icons.music_video,
            size: Size(50, 50),
            onPress: () {},
          ),
        ],
      ),
    );
  }
}