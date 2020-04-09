class Medications {
  final int id;
  final String name;
  final int size;
  final String image;

  Medications({this.id, this.name, this.size, this.image});
}

class ListMed{
    var listMed = [ 
      
      Medications(id:0 , name: "Ben-u-ron 500g", size: 20,  image:"https://www.farmaciasportuguesas.pt/catalogo/media/catalog/product/cache/1/image/800x800/9df78eab33525d08d6e5fb8d27136e95/8/1/816861720161010125245_1.jpg" ),
      Medications(id:1 , name: "Folicil", size: 60,  image:"https://demaeparamae.pt/sites/default/files/styles/width400/public/produtos/106027/img1123_0.jpg?itok=VA9a-XlT" ),
      Medications(id:2 , name: "Eutirox 50", size: 50,  image:"https://www.chedraui.com.mx/medias/750129823490-01-CH1200Wx1200H?context=bWFzdGVyfHJvb3R8NzkyNDN8aW1hZ2UvanBlZ3xoNTYvaDZkLzg4MzQ0NzE5MTk2NDYuanBnfDI1OTg1ZGI2OThhNmY2NjIzMzYzODRiMWUyYzkwNGE5ODhmNmQ0NjI3N2I5OWVmMDE4MjgxNzY3NTE2Mjk5MjY" ),
      Medications(id:3 , name: "Eutirox 75", size: 50,  image:"https://www.chedraui.com.mx/medias/750129823490-01-CH1200Wx1200H?context=bWFzdGVyfHJvb3R8NzkyNDN8aW1hZ2UvanBlZ3xoNTYvaDZkLzg4MzQ0NzE5MTk2NDYuanBnfDI1OTg1ZGI2OThhNmY2NjIzMzYzODRiMWUyYzkwNGE5ODhmNmQ0NjI3N2I5OWVmMDE4MjgxNzY3NTE2Mjk5MjY" ),
    
     ];

    getOne(int i) async{
      if(i<=listMed.length){
          return listMed[i];
      }else{
        return Null;
      }
    }
}

