import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:core';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/auth/userdata.dart';
import 'package:untitled1/database/database.dart';
import 'dart:io';
import 'accuil.dart';
import 'auth/user.dart';
import 'historique.dart';

class InfoPerso extends StatefulWidget {
  const InfoPerso({Key? key}) : super(key: key);
  @override
  State<InfoPerso> createState() => _InfoPersoState();
}

class _InfoPersoState extends State<InfoPerso> {
  File? image;
  var _imageFile;
  late String _url;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    final livI = user!.uid;
    String livN = "";
    String livPh = "";
    return StreamBuilder<Userdata>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Userdata? userd = snapshot.data;
            livN = userd!.name;
            livPh = userd.phone;

            return SafeArea(
                child: Scaffold(
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.endTop,
                    floatingActionButton: SizedBox.fromSize(
                      size: Size.fromRadius(16),
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Acceuil(etape: 'aucune commande')));
                        },
                        child: Icon(Icons.clear_rounded, color: Colors.white),
                        backgroundColor: Color(0xffb80000),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ),
                    body: Stack(clipBehavior: Clip.none, children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/Profile.png"),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Column(children: [
                        SizedBox(
                          height: 90.h,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ImageProfile(),
                            ]),
                        SizedBox(height: 20.h),
                        AutoSizeText(userd.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            )),
                        SizedBox(
                          height: 50.h,
                        ),
                        Card(
                            child: SizedBox(
                               height: 50.23.h,
                               width: 305.45.h,
                            child: Row(
                            children: [
                              Icon(
                                MdiIcons.account,
                                color: Colors.black,
                                size: 25.sp,
                              ),
                              AutoSizeText(
                                '$livN',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )),
                        SizedBox(
                          height: 15.h,
                        ),
                        Card(
                            child: SizedBox(
                              height: 50.23.h,
                              width: 305.45.h,
                            child: Row(
                            children: [
                              Icon(
                                MdiIcons.email,
                                color: Colors.black,
                                size: 25.sp,
                              ),
                              AutoSizeText(
                                user.email.toString(),
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )),
                        SizedBox(
                          height: 15.h,
                        ),
                        Card(
                            child: SizedBox(
                              height: 50.23.h,
                              width: 305.45.h,
                            child: Row(
                            children: [
                              Icon(
                                MdiIcons.phone,
                                color: Colors.black,
                                size: 25.sp,
                              ),
                              AutoSizeText(
                                '$livPh',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )),
                        SizedBox(
                          height: 15.h,
                        ),
                        Card(
                            child: SizedBox(
                              height: 50.23.h,
                              width: 305.45.h,
                            child: Row(
                            children: [
                              Icon(
                                MdiIcons.identifier,
                                color: Colors.black,
                                size: 25.sp,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Historiques()));
                                },
                                child: AutoSizeText(
                                  '$livI',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        )),
                        SizedBox(
                          height: 100.h,
                        ),
                      ]),
                    ])));
          } else {
            return SafeArea(
                child: Scaffold(
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.endTop,
                    floatingActionButton: SizedBox.fromSize(
                      size: Size.fromRadius(16),
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Acceuil(etape: 'aucune commande')));
                        },
                        child: Icon(Icons.clear_rounded, color: Colors.white),
                        backgroundColor: Color(0xffb80000),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ),
                    body: Stack(clipBehavior: Clip.none, children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  DatabaseService(uid: user.uid).image()),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Column(children: [
                        SizedBox(
                          height: 90.h,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ImageProfile(),
                            ]),
                        SizedBox(height: 20.h),
                        AutoSizeText(livN,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            )),
                        SizedBox(
                          height: 50.h,
                        ),
                        Card(
                            child: SizedBox(
                          height: 50.23.h,
                          width: 305.45.h,
                          child: Row(
                            children: [
                              Icon(
                                MdiIcons.account,
                                color: Colors.black,
                                size: 25.sp,
                              ),
                             AutoSizeText(
                                '$livN',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )),
                        SizedBox(
                          height: 15.h,
                        ),
                        Card(
                            child: SizedBox(
                          height: 50.23.h,
                          width: 305.45.h,
                          child: Row(
                            children: [
                              Icon(
                                MdiIcons.email,
                                color: Colors.black,
                                size: 25.sp,
                              ),
                              AutoSizeText(
                                user.email.toString(),
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )),
                        SizedBox(
                          height: 15.h,
                        ),
                        Card(
                            child: SizedBox(
                          height: 50.23.h,
                          width: 305.45.h,
                          child: Row(
                            children: [
                              Icon(
                                MdiIcons.phone,
                                color: Colors.black,
                                size: 25.sp,
                              ),
                              AutoSizeText(
                                '$livPh',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )),
                        SizedBox(
                          height: 15.h,
                        ),
                        Card(
                            child: SizedBox(
                          height: 50.23.h,
                          width: 305.45.h,
                          child: Row(
                            children: [
                              Icon(
                                MdiIcons.identifier,
                                color: Colors.black,
                                size: 25.sp,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Historiques()));
                                },
                                child: AutoSizeText(
                                  '$livI',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        )),
                        SizedBox(
                          height: 100.h,
                        ),
                      ]),
                    ])));
          }
        });
  }

  Widget ImageProfile() {
    final user = Provider.of<MyUser?>(context);

    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50.sp,
            backgroundImage: _imageFile == null
                ? NetworkImage(DatabaseService(uid: user!.uid).image())
                : FileImage(File(_imageFile.path)) as ImageProvider,
          ),
          Positioned(
            right: 5.w,
            bottom: 5.h,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => change()),
                  );
                },
                child: CircleAvatar(
                  radius: 15.sp,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                    size: 15.sp,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget change() {
    return Container(
      height: 200.h,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [
          SizedBox(
            height: 15.h,
          ),
          AutoSizeText(
            "Changer votre photo de profile",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    pickpicture(ImageSource.camera);
                  },
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    size: 18.sp,
                  )),
              SizedBox(
                width: 4.w,
              ),
              GestureDetector(
                onTap: () {
                  pickpicture(ImageSource.camera);
                  uploadImage(context);
                },
                child: AutoSizeText(
                  "Prendre une photo",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(children: [
            IconButton(
                onPressed: () {
                  pickpicture(ImageSource.gallery);
                },
                icon: Icon(
                  Icons.image,
                  size: 18.sp,
                )),
            SizedBox(
              width: 4.w,
            ),
            GestureDetector(
              onTap: () {
                pickpicture(ImageSource.gallery);
              },
              child: AutoSizeText(
                "importer une photo",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }

  Future pickpicture(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
      );
      if (pickedFile == null) return;
      final imageTemporary = File(pickedFile.path);
      setState(() {
        this._imageFile = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
  }

  void uploadImage(context) async {
    final user = Provider.of<MyUser?>(context);
    try {
      FirebaseStorage storage =
          FirebaseStorage.instanceFor(bucket: 'gs://projet-8522f.appspot.com');
      Reference ref = storage.ref().child(p.basename(_imageFile.path));
      UploadTask storageUploadTask = ref.putFile(_imageFile);
      TaskSnapshot taskSnapshot = await storageUploadTask;
      String url = await taskSnapshot.ref.getDownloadURL();
      print('url$url');
      DatabaseService(uid: user!.uid).urlimage(url);
      setState(() {
        DatabaseService(uid: user.uid).urlimage(url);
        _url = url;
      });
    } catch (e) {}
  }
}
