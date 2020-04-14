

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:location/location.dart';
import '../model/house.dart';
import 'dart:math';


 Location location = new Location();
 

 Future selectNotification(String payload) async {
     if (payload != null) {
     
    }
  }
 void printNoService() async{
   
   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
   AndroidFlutterLocalNotificationsPlugin fl = AndroidFlutterLocalNotificationsPlugin();
  print("bo");

   var initializationSettingsAndroid = AndroidInitializationSettings('logo');
      var initializationSettings = InitializationSettings(initializationSettingsAndroid, null);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);
      var androidPlatformChannelSpecifics = AndroidNotificationDetails('2', 'aiai','your channel description',
        importance: Importance.Max, priority: Priority.Max, ticker: 'ticker');
        
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, null);
      await flutterLocalNotificationsPlugin.show(
          0, 'Ligue o gps', 'Algumas features necessitam de acesso ao GPS', platformChannelSpecifics,
          payload: 'item x'); 

  
 }

  void printSair() async{
   
   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
   AndroidFlutterLocalNotificationsPlugin fl = AndroidFlutterLocalNotificationsPlugin();
   var initializationSettingsAndroid = AndroidInitializationSettings('logo');
      var initializationSettings = InitializationSettings(initializationSettingsAndroid, null);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);
      var androidPlatformChannelSpecifics = AndroidNotificationDetails('2', 'aiai','your channel description',
        importance: Importance.Max, priority: Priority.Max, ticker: 'ticker');
        
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, null);
      await flutterLocalNotificationsPlugin.show(
          0, 'Está a sair de Casa', 'Verifique se não tem de tomar algum medicamento', platformChannelSpecifics,
          payload: 'item x'); 

  
 }

  // verifica se o serviço esta on
  _getServiceStatus() async {
      bool _serviceEnabled;
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        return false;
      }else{
       return true;
      }
    }

  //Verifica se tem permissões
  _getPermission() async {

    PermissionStatus _permissionGranted;
    _permissionGranted = await location.hasPermission();
        if (_permissionGranted != PermissionStatus.GRANTED) {
          return false;
        }else{
         return true;         
    }
  }

  class House {
    final int id;
    final String nome;
    final double lat;
    final double long;
    final double raio;
    final int active;

    House({this.id, this.nome, this.lat, this.long, this.raio, this.active});

}


    List<House> houseList= [];
    final dbHelper = DatabaseHelper2.instance;
   //retorna todas as casas
   _query() async {
     houseList.clear();
     print('query all rows:');
      final allRows = await dbHelper.queryAllRows();
      print('query all rows:');
      allRows.forEach((row) {
          houseList.add(
            House(
              id: row['_id'],
              nome: row['name'],
              lat: row ['lat'],
              long: row['long'],
              active: row['active'],
              raio: row['raio'],
            ),
          );
        });
  }

  _updateInside( int id, String name, double lat, double long, double raio) async{
    Map<String, dynamic> row = {
                  DatabaseHelper2.columnId : id,
                  DatabaseHelper2.columnName : name,
                  DatabaseHelper2.columnLat  : lat,
                  DatabaseHelper2.columnLong : long,
                  DatabaseHelper2.columnActive : 1,
                  DatabaseHelper2.columnRaio : raio,
                };

            final ida = await dbHelper.update(row);
            print('inserted row id: $ida');
  }

  _updateOutside( int id, String name, double lat, double long, double raio) async{
    Map<String, dynamic> row = {
                  DatabaseHelper2.columnId : id,
                  DatabaseHelper2.columnName : name,
                  DatabaseHelper2.columnLat  : lat,
                  DatabaseHelper2.columnLong : long,
                  DatabaseHelper2.columnActive : 0,
                  DatabaseHelper2.columnRaio : raio,
                };

            final ida = await dbHelper.update(row);
            print('inserted row id: $ida');
  }



 _measure(double lat1,double lon1,double lat2,double lon2){  // generally used geo measurement function
    var R = 6378.137; // Radius of earth in KM
    var dLat = lat2 * pi / 180 - lat1 *pi / 180;
    var dLon = lon2 * pi / 180 - lon1 * pi / 180;
    var a = sin(dLat/2) * sin(dLat/2) +
    cos(lat1 * pi / 180) * cos(lat2 * pi / 180) *
    sin(dLon/2) * sin(dLon/2);
    var c = 2 * atan2(sqrt(a), sqrt(1-a));
    var d = R * c;
    return d * 1000; // meters
}
    // localização do utilizador
    getLocationAlarm() async {
        print("alarm");
      _getServiceStatus().then((service){
            if(service){
              _getPermission().then((permission){
                if(permission){
                      location.getLocation().then((loca){
                        _query().then((Null)
                          {
                            houseList.forEach((f){
                              double distance = _measure(f.lat, f.long, loca.latitude, loca.longitude);
                              if(f.active == 1){
                                if(distance > f.raio){
                                  printSair();
                                  _updateOutside(f.id, f.nome, f.lat, f.long, f.raio);
                                }
                              }else{
                                 if(distance < f.raio){
                                   _updateInside(f.id, f.nome, f.lat, f.long, f.raio);
                                }
                              }
                            });
                          }
                        );
                      });
                    // printHello();
                }
              });
            }else{
              printNoService();
            }
      });
}  




  


