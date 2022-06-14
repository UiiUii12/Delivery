import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/accuil.dart';

import 'package:untitled1/database/database.dart';
import 'auth/user.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);
static List <String> l=[];
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<MyUser?>(context);
    return StreamBuilder<List <String>>(
      stream: DatabaseService(uid: user!.uid).arriverList,
      builder: (context, snapshot) {
        if (snapshot.hasData){
          l=snapshot.data!;
          
        }
        return Acceuil(etape: "Aucune commande");
      }
    );
  }
}
