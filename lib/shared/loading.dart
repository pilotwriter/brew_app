import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.grey[700],
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.tealAccent[200],
          size: 50,
        ),
      ),
    );
  }
}
