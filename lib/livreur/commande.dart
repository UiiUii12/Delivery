

class Commande {

  	 final num LongitudeRestorant ;
   final num LatitudeRestoront  ;
    final num LongitudeClient ;
   final num LatitudeClient  ;
    final num Nemero;
    final String ID;


    Commande({required this.LatitudeClient,required this.LatitudeRestoront,required this.LongitudeClient,required this.LongitudeRestorant,required this.Nemero,required this.ID} );
}
class Exist {
  bool exist;
  Exist({required this.exist});

}