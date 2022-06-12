import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled1/auth/user.dart';
import 'package:untitled1/recuperation.dart';
import 'package:untitled1/shared/loading.dart';
import 'auth/auth.dart';

class Connexion extends StatefulWidget {
  const Connexion({Key? key}) : super(key: key);

  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  final formKey = GlobalKey<FormState>();
  bool validate = false;
  bool _secureText = true;
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  bool submit = false;
  bool submit2 = false;
  bool loading = false;
  late TextEditingController controller;
  String _id = '', _password = '', erreur = '';
  FirebaseAuth usertab = FirebaseAuth.instance;
  AuthService _auth = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.addListener(() {
      setState(() {
        submit = myController.text.isNotEmpty;
      });
    });
    myController2.addListener(() {
      setState(() {
        submit2 = myController2.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    myController2.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Form(
              key: formKey,
              child: SafeArea(
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/Se connecter.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Scaffold(
                      backgroundColor: Colors.transparent,
                      body: SingleChildScrollView(
                        child: SafeArea(
                          child: Column(
                            children: [
                              Column(children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      30.w, 100.h, 38.w, 50.h),
                                  child: Container(
                                    height: 80.h,
                                    width: 283.w,
                                    child: Center(
                                      child: AutoSizeText('Se connecter',
                                          textScaleFactor: 0.96.sp,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 40.sp,
                                            color: Colors.black,
                                          )),
                                    ),
                                  ),
                                ),
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
                                      borderRadius: BorderRadius.circular(12.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 5.r,
                                          blurRadius: 7.r,
                                          offset: Offset(5, 5),
                                        ),
                                      ]),
                                  child: Column(
                                    //column de contenu de container
                                    children: [
                                      SizedBox(
                                        //le premier espace
                                        height: 15.h,
                                      ),
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.w),
                                          child: Column(
                                            children: [
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 14.h,
                                                              horizontal: 0.w),
                                                      child: Container(
                                                        width: 260.w,
                                                        height: 40.h,
                                                        color:
                                                            Colors.transparent,
                                                        child: TextFormField(
                                                          //lgris lewel
                                                          controller:
                                                              myController,
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    10.0.h),
                                                            counterText: "",
                                                            border: InputBorder
                                                                .none,
                                                            hintText: 'Email',
                                                            hintStyle:
                                                                TextStyle(
                                                              fontSize: 15.sp,
                                                              fontFamily:
                                                                  'Poppins',
                                                              color: Colors
                                                                  .grey[500],
                                                            ),
                                                            fillColor: Color(
                                                                0xffF6F6F6),
                                                            filled: true,
                                                          ),
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          keyboardType:
                                                              TextInputType
                                                                  .emailAddress,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              this._id = value;
                                                            });
                                                          },
                                                          autofillHints: [
                                                            AutofillHints.email
                                                          ],
                                                          validator: (email) => email !=
                                                                      null &&
                                                                  !EmailValidator
                                                                      .validate(
                                                                          email)
                                                              ? 'Email non valide'
                                                              : null,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      //troisieme espace
                                                      height: 15.h,
                                                    ),
                                                    Container(
                                                      //lgris deuxieme
                                                      width: 260.w,
                                                      height: 40.h,
                                                      color: Colors.transparent,
                                                      child: TextFormField(
                                                        controller:
                                                            myController2,
                                                        textAlign:
                                                            TextAlign.left,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                  10.0.h),
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'Mot de passe',
                                                          suffixIcon:
                                                              IconButton(
                                                            icon: Icon(
                                                                _secureText
                                                                    ? Icons
                                                                        .remove_red_eye
                                                                    : Icons
                                                                        .visibility_off,
                                                                color: Colors
                                                                    .grey[500]),
                                                            iconSize: 20.sp,
                                                            onPressed: () {
                                                              setState(() {
                                                                _secureText =
                                                                    !_secureText;
                                                              });
                                                            },
                                                          ),
                                                          hintStyle: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors
                                                                .grey[500],
                                                            fontSize: 15.sp,
                                                          ),
                                                          fillColor:
                                                              Color(0xffF6F6F6),
                                                          filled: true,
                                                          isCollapsed: true,
                                                        ),
                                                        obscureText:
                                                            _secureText,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            this._password =
                                                                value;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      //troisieme espace
                                                      height: 3.h,
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Recuperation()));
                                                      },
                                                      child: AutoSizeText(
                                                        'Mot de passe oublié?',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12.sp,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                              SizedBox(
                                                height: 18.h,
                                              ),
                                              Container(
                                                color: Colors.transparent,
                                                child: SizedBox(
                                                  width: 195.w,
                                                  height: 42.h,
                                                  child: ElevatedButton(
                                                    onPressed: submit && submit2
                                                        ? () async {
                                                            final form = formKey
                                                                .currentState!;
                                                            if (form
                                                                .validate()) {
                                                              final email =
                                                                  myController
                                                                      .text;
                                                            }
                                                            final result1 =
                                                                await Connectivity()
                                                                    .checkConnectivity();
                                                            showToast1(result1);
                                                            setState(() =>
                                                                loading = true);
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                            MyUser? result = await _auth
                                                                .signeInWithEmailAndPassword(
                                                                    this._id,
                                                                    this._password);
                                                            if (result ==
                                                                null) {
                                                              setState(() {
                                                                loading = false;
                                                              });
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    title: AutoSizeText(
                                                                        'Mot de passe/Email incorrect'),
                                                                    content: Text(
                                                                        'Le mot de passe ou email que vous avez saisi est incorrect. Veuillez réssayer. '),
                                                                    actions: <
                                                                        Widget>[
                                                                      TextButton(
                                                                        child: AutoSizeText(
                                                                            'OK'),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        style: TextButton.styleFrom(
                                                                            primary:
                                                                                Color(0xffB80000)),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            }
                                                            setState(() => {
                                                                  submit = true,
                                                                  submit2 = true
                                                                });
                                                          }
                                                        : null,
                                                    child: AutoSizeText(
                                                        'Se connecter',
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                          color: Colors.white,
                                                        )),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      onSurface:
                                                          Color(0xffb90000),
                                                      shadowColor: Colors.grey,
                                                      primary:
                                                          Color(0xffb80000),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                //cienquiéme espace
                                                height: 15.h,
                                              ),
                                            ],
                                          )), //container lbyadh
                                    ],
                                  ),
                                ),
                              ])
                            ],
                          ),
                        ),
                      ))
                ]),
              ),
            ),
          );
  }

  void showToast1(ConnectivityResult result) {
    final hasInternet = result == ConnectivityResult.none;
    String Message = hasInternet ? 'Non connecté' : '';
    Color color = hasInternet ? Colors.white : Colors.transparent;
    Color colorText = hasInternet ? Colors.black : Colors.transparent;
    Fluttertoast.showToast(
        msg: Message,
        fontSize: 15.sp,
        backgroundColor: color,
        textColor: colorText);
  }
}
