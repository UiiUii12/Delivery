import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'package:untitled1/wrapper.dart';

class SplachScreen extends StatefulWidget {
  @override
  _SplachScreenState createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  late StreamSubscription subscription;
  late ConnectivityResult result;
  @override
  void initState() {
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen(navigate);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffb80000),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: (MediaQuery.of(context).size.height) * (1 / 4),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'images/Oussama_Express-removebg-preview.png')),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SpinKitThreeBounce(
              size: 30.sp,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  void navigate(ConnectivityResult result) {
    result != ConnectivityResult.none
        ? Timer(
            Duration(milliseconds: 1500),
            () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Wrapper())))
        : Container();
  }
}
