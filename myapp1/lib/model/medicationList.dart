class Medication {
  final int id;
  final String name;
  final int size;
  final String image;

  Medication({this.id, this.name, this.size, this.image});
}

class ListMed{
    var listMed = [ 
      
      Medication(id:0 , name: "Ben-u-ron 500g", size: 20,  image:"https://www.farmaciasportuguesas.pt/catalogo/media/catalog/product/cache/1/image/800x800/9df78eab33525d08d6e5fb8d27136e95/8/1/816861720161010125245_1.jpg" ),
      Medication(id:1 , name: "Folicil", size: 60,  image:"https://demaeparamae.pt/sites/default/files/styles/width400/public/produtos/106027/img1123_0.jpg?itok=VA9a-XlT" ),
    
     ];

    getOne(int i) async{
      if(i<=listMed.length){
          return listMed[i];
      }else{
        return Null;
      }
    }
}

