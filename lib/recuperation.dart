import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'connexion.dart';

class Recuperation extends StatelessWidget {
  Recuperation({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double HeightSize = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/Se connecter.png"),
                fit: BoxFit.cover),
          ),
        ),
        Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
            floatingActionButton: SizedBox.fromSize(
              size: Size.fromRadius(20),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Connexion()));
                },
                child: Icon(Icons.arrow_back, color: Colors.black),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
                child: SafeArea(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: (HeightSize - 80.h - 288.h) / 3,
                            ),
                            Center(
                              child: Container(
                                height: 60.h,
                                child: FittedBox(
                                  child: AutoSizeText('Récupération',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 40.sp,
                                        color: Colors.black,
                                      )),
                                ),
                              ),
                            ),
                            SizedBox(height: 40.h),
                            Container(
                              //container card
                              width: 300.w,
                              height: 288.h,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.1.w,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 5.r,
                                      blurRadius: 7.r,
                                      offset: Offset(5, 5),
                                    ),
                                  ]),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50.h,
                                  ),
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30.w),
                                      child: Column(
                                        children: [
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 14.h),
                                                  child: Container(
                                                    width: 260.w,
                                                    height: 40.h,
                                                    color: Colors.transparent,
                                                    child: TextFormField(
                                                      controller:
                                                          emailController,
                                                      textAlign: TextAlign.left,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.all(
                                                                10.0.h),
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'Adresse email',
                                                        hintStyle: TextStyle(
                                                          fontSize: 15.sp,
                                                          fontFamily: 'Poppins',
                                                          color:
                                                              Colors.grey[500],
                                                        ),
                                                        fillColor:
                                                            Color(0xffF6F6F6),
                                                        filled: true,
                                                        isCollapsed: true,
                                                      ),
                                                      keyboardType:
                                                          TextInputType
                                                              .emailAddress,
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      validator: (email) =>
                                                          email != null &&
                                                                  !EmailValidator
                                                                      .validate(
                                                                          email)
                                                              ? "invalide email"
                                                              : null,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 35.h,
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                              ]),
                                          SizedBox(
                                            height: 40.h,
                                          ),
                                          Container(
                                            color: Colors.transparent,
                                            child: SizedBox(
                                              width: 200.w,
                                              height: 40.h,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  resetEmail();
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Connexion()));
                                                },
                                                child: AutoSizeText(
                                                    'envoyer le lien',
                                                    style: TextStyle(
                                                      fontSize: 20.sp,
                                                      color: Colors.white,
                                                    )),
                                                style: ElevatedButton.styleFrom(
                                                  shadowColor: Colors.grey,
                                                  primary: Color(0xffb80000),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ))),
      ]),
    );
  }

  Future resetEmail() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text.trim());
  }
}
