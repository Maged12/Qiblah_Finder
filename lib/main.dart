import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import './loading_indicator.dart';
import './qiblah_compass.dart';
import 'package:location/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();
  @override
  void initState() {
    Location().getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff0c7b93),
        primaryColorLight: Color(0xff00a8cc),
        primaryColorDark: Color(0xff27496d),
        accentColor: Color(0xffecce6d),
      ),
      darkTheme: ThemeData.dark().copyWith(accentColor: Color(0xffecce6d)),
      home: Scaffold(
        appBar: AppBar(
          title: Container(
            width: double.infinity,
            child: Center(
              child: const Text('الباحث عن الكعبة المشرفة'),
            ),
          ),
        ),
        body: FutureBuilder(
          future: _deviceSupport,
          builder: (_, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return LoadingIndicator();
            if (snapshot.hasError)
              return Center(
                child: Text("Error: ${snapshot.error.toString()}"),
              );

            if (snapshot.data)
              return QiblahCompass();
            else
              return Container(
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Your Device does not support the sensor",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              );
          },
        ),
      ),
    );
  }
}
