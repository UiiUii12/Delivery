import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/accuil.dart';
import 'package:untitled1/wrapper2.dart';
import 'auth/user.dart';
import 'connexion.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    if (user == null) {
      return Connexion();
    } else {
      print("hi");
      return Wrapper2();
    }
  }
}
