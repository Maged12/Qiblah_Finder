import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationErrorWidget extends StatelessWidget {
  final String error;
  final Function callback;

  const LocationErrorWidget({Key key, this.error, this.callback})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    final box = SizedBox(height: 32);
    final errorColor = Color(0xffb00020);

    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.location_off,
              size: 150,
              color: errorColor,
            ),
            box,
            Text(
              error,
              style: TextStyle(
                  color: errorColor, fontWeight: FontWeight.bold ,fontSize: 18),
              textAlign: TextAlign.center,
            ),
            box,
            RaisedButton(
              child: Text("أعد المحاولة",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
              onPressed: () {
                Location().getLocation();
                if (callback != null) callback();
              },
            )
          ],
        ),
      ),
    );
  }
}