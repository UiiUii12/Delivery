import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/accuil.dart';

import 'package:untitled1/database/database.dart';
import 'package:untitled1/wrapper3.dart';
import 'auth/user.dart';
import 'livreur/commande.dart';


class Wrapper2 extends StatelessWidget {
  const Wrapper2({Key? key}) : super(key: key);
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
        return StreamBuilder<Exist>(

           stream: DatabaseService(uid: user.uid).exist,

          builder: (context, snapshot) {

             if(snapshot.hasData){



               if(snapshot.data!.exist==false && !Wrapper2.l.isEmpty){
                 print("faaaaaaaaaaaaaaaaaaaaaaaaaaaa");

                 return Wrapper3();

               }else{
                 print("moounikkkkkkkkkkkkkkkkkkkkk");
                 return Acceuil(etape: "Aucune commande");
               }
             }else {
               print("moounikkkkkkkkkkkkkkkkkkkkk");
               return Acceuil(etape: "Aucune commande");
             }

          }
        );
      }
    );
  }
}
