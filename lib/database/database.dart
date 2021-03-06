import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled1/auth/userdata.dart';
import 'package:untitled1/livreur/historique.dart';
import 'package:untitled1/wrapper3.dart';
import '../livreur/commande.dart';
import '../livreur/theorder.dart';
//hi

class DatabaseService {
  final String uid ;
 static List<TheOrder>? list,orderl;
 static String? imag ,sexe,ID,IdRes,IdCommande;
 static double? latR,longR,latC,longC,Nemero,lo,la;
  DatabaseService( { required this.uid});


  //Collectoin reference
  final CollectionReference livreurCollection = FirebaseFirestore.instance.collection('livreur');
  // get livreur stream


  // GetUpHistorique
List <Historique> _historiqueList(QuerySnapshot snapshot ){

   return snapshot.docs.map((doc)
   {

     return Historique(date: doc.get("date")??"", heure: doc.get("heure")??'');


   }).toList();

}
  List <TheOrder> _OrderList(QuerySnapshot snapshot ){

    return snapshot.docs.map((doc)
    {

      return TheOrder(nomplat:doc.get("nom"),quantite: doc.get("quantite"));


    }).toList();

  }


  Commande _commandeList(DocumentSnapshot  snapshot){


  return Commande(LatitudeClient:snapshot.get("LatitudeClient").toDouble(),LatitudeRestoront: snapshot.get("LatitudeRestaurant").toDouble(),LongitudeClient :snapshot.get("LongitudeClient").toDouble() ,LongitudeRestorant: snapshot.get("LongitudeRestaurant").toDouble(), Nemero: snapshot.get("Nemero").toDouble(),ID:snapshot.get("Nemero").toString() );




  }


  // edentifi evry time if any changed in document
  Stream<List <Historique>> get livreurhis {
    return livreurCollection.doc(uid).collection("hestorique").snapshots().map((snapshot)=> _historiqueList(snapshot));

  }
  Stream<Commande> get livreurcom {

    return livreurCollection.doc(uid).collection("commandes").doc("commande").snapshots().map((snapshot) => _commandeList(snapshot));

  }

  Stream<List <TheOrder>> get Order {

    return livreurCollection.doc(uid).collection("commandes").doc("commande").collection("plats").snapshots().map((snapshot) => _OrderList(snapshot));

  }

//SetUpHestorique
Future updateHestorique(String s,String v){
  return livreurCollection.doc(uid).collection("hestorique").add({"date":s,"heure":v}) ;
}

//deletecommonde
Future deletecommande()async {
  var snapshots = await livreurCollection.doc(uid).collection("commandes").doc("commande").collection("plats").get();
  for (var doc in snapshots.docs) {
    await doc.reference.delete();
  }
  return
    livreurCollection.doc(uid).collection("commandes").doc("commande").delete();
}
//userdata
  Userdata _userdatasnap(DocumentSnapshot snapshot){


  return Userdata(name: snapshot.get("nom").toString(), email: snapshot.get("email").toString(), phone:snapshot.get("phone").toString(),sexe:snapshot.get("sexe").toString(),image: snapshot.get("image").toString() );
  }

Stream <Userdata> get userData{

  return livreurCollection.doc(uid).snapshots().map((snapshot) =>_userdatasnap(snapshot));
  }
  Exist _existsnap(DocumentSnapshot snapshot){
  return Exist(exist: snapshot.get("exist"));
  }

  Stream <Exist> get exist{
  
  return livreurCollection.doc(uid).collection("commandes").doc("commande").snapshots().map((snapshot) => _existsnap(snapshot));
  }
   setupexist () async {
  await livreurCollection.doc(uid).collection("commandes").doc("commande").set({"exist":false});
}
  Commande commande(){


    livreurCollection.doc(uid).collection("commandes").doc("commande").get().then((value) {
    latR=value.get("LatitudeRestaurant").toDouble();
    latC=  value.get("LatitudeClient").toDouble();
    longR=  value.get("LongitudeRestaurant").toDouble();
    longC= value.get("LongitudeClient").toDouble();
    Nemero= value.get("Nemero").toDouble();
    ID=value.get("ID").toString();
    } );


latR ??= 0;latC ??= 0;longC??= 0;longR ??= 0;Nemero ??= 0;ID??="";

    return Commande(LatitudeClient:latC!,LatitudeRestoront: latR!,LongitudeClient:longC! ,LongitudeRestorant:longR!, Nemero: Nemero! ,ID:ID!) ;




  }
  String image (){

  livreurCollection.doc(uid).get().then((value) => imag= value.get("image"));
  imag??="";
    return  imag!;
  }
  urlimage (String s)async{
    await livreurCollection.doc(uid).set({"image":s});
  }
  Future updateArchive(String id,String heure,String date,String docid){
  for(int i =0;i<list!.length;i++){
    FirebaseFirestore.instance.collection('Archive').doc(docid+uid[1]+uid[2]).collection("plats").add({"nom":list![i].nomplat,"quantite":list![i].quantite });
  }

Nemero??=0;
    return FirebaseFirestore.instance.collection('Archive').doc(docid).set({"Nemero":Nemero,"idLivreur":id,"heure":heure,"date":date}) ;

  }
String sexe1(){
  livreurCollection.doc(uid).get().then((value) => sexe= value.get("sexe"));
  sexe??="M";
  return sexe!;
}
/////////////////////////////////////////////////////////////////////////////////////////
  UpdateExistCommande()async{


    await  FirebaseFirestore.instance.collection('client').doc(ID!).update({"existCommande":true});
  }
  /////////////////////////////////////////////////////////////
  creecommande(Commande commande)async{
print("////////////////////cree commande////////////////////////");
print(commande.ID);
print(commande.LongitudeRestorant);
print(commande.LongitudeClient);
print(commande.LatitudeClient);
print(commande.LongitudeClient);
print(commande.Nemero);

     await livreurCollection.doc(uid).collection("commandes").doc("commande").update({"LatitudeClient":commande.LatitudeClient,"LatitudeRestaurant": commande.LatitudeRestoront,"LongitudeClient":commande.LongitudeClient ,"LongitudeRestaurant":commande.LongitudeRestorant, "Nemero": commande.Nemero ,"ID":commande.ID,"exist":true});
Wrapper3.exi=true;

  }
  List <String> _arriverList(QuerySnapshot snapshot ){


    return snapshot.docs.map((doc)
    {
      return doc.id.toString();

    }).toList();

  }
  Stream<List <String>> get arriverList {

    return FirebaseFirestore.instance.collection('Commandes').snapshots().map((snapshot)=> _arriverList(snapshot));

  }
  List <TheOrder> _orderList(QuerySnapshot snapshot ){

    return snapshot.docs.map((doc)
    {

      IdRes = doc.get("ResId");
      IdCommande=doc.id;

print(doc.get("nom").toString()+"  "+doc.get("description").toString());
print(doc.get("quentite"));
      return TheOrder(nomplat: doc.get("nom").toString()+"  "+doc.get("description").toString(), quantite: doc.get("quentite").toString());


    }).toList();

  }
  Stream<List <TheOrder>> order (String id){

    return FirebaseFirestore.instance.collection('Commandes').doc(id).collection("commade").snapshots().map((snapshot)=> _orderList(snapshot));

  }
 getLonLat()async{

  await FirebaseFirestore.instance.collection('Restaurant').doc(IdRes).get().then((value) => la=value.get("latitude"));
  await FirebaseFirestore.instance.collection('Restaurant').doc(IdRes).get().then((value) => lo=value.get("longitude"));


}

  Commande commande2(String id){


    FirebaseFirestore.instance.collection('Commandes').doc(id).collection("commade").doc(IdCommande).get().then((value) {
      latR=la;
      latC=  value.get("Latitude").toDouble();
      longR=  lo;
      longC= value.get("Longitude").toDouble();
      Nemero= 0;
      ID=value.get("UserID").toString();
    } );


    latR ??= 0;latC ??= 0;longC??= 0;longR ??= 0;Nemero ??= 0;ID??="";

    return Commande(LatitudeClient:latC!,LatitudeRestoront: latR!,LongitudeClient:longC! ,LongitudeRestorant:longR!, Nemero: Nemero! ,ID:ID!) ;




  }
  creeOrther()async{
    for(int i =0;i<orderl!.length;i++){
      await livreurCollection.doc(uid).collection("commandes").doc("commande").collection("plats").add({"nom":orderl![i].nomplat,"quantite":orderl![i].quantite });
    }
  }
  suppremercommande(String id)async{
  await FirebaseFirestore.instance.collection('Commandes').doc(id).delete();
  }
  setupdown() async {
    await livreurCollection.doc(uid).collection("commandes").doc("commande").update({"exist":true});
  }
}

