import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/accuil.dart';

import 'package:untitled1/database/database.dart';
import 'package:untitled1/livreur/theorder.dart';
import 'package:untitled1/wrapper2.dart';
import 'auth/user.dart';


class Wrapper3 extends StatelessWidget {
  const Wrapper3({Key? key}) : super(key: key);
  static List <String> l=[];
  static bool exi =false;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);
  if(Wrapper2.l.isNotEmpty && exi==false) {

    return StreamBuilder<List <TheOrder>>(
        stream: DatabaseService(uid: user!.uid).order(Wrapper2.l[0]),
        builder: (context, snapshot) {

          if (snapshot.hasData) {

            DatabaseService(uid: user.uid).setupdown();
            DatabaseService.orderl = snapshot.data;

            DatabaseService(uid: user.uid).creeOrther();

            DatabaseService(uid: user.uid).getLonLat();

            DatabaseService(uid: user.uid).creecommande(DatabaseService(uid: user.uid).commande2(Wrapper2.l[0]));
            DatabaseService(uid: user.uid).suppremercommande(Wrapper2.l[0]);

          }
          return Acceuil(etape: "Aucune commande");
        }
    );
  }
  else {return Acceuil(etape: "Aucune commande");}
  }
}
