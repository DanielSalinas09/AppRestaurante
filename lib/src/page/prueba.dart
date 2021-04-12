import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyhomePage extends StatefulWidget {
  MyhomePage({Key key}) : super(key: key);

  @override
  _MyhomePageState createState() => _MyhomePageState();
}

class _MyhomePageState extends State<MyhomePage> {
  




  getUserData() async {
    final response = await http.post(
    Uri.parse('https://backend-delivery.azurewebsites.net/api/auth/admin/registro') , 
    body: {
    'numero':'30161623030',
    'nombre':"Hernan david",
    'apellidos':"escorcia samperr",
    'email':"wisholloww@gmail.com"}
  );
  final jsonData = jsonDecode(response.body);
   var users =[];
      
      var data = jsonData["message"] ;

      User user = User(data);
      users.add(user);
    
    print(response.body);
    return users;
  }
  TextEditingController inputcontroller=new TextEditingController();
  String getvalue;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text('User Data'),),
      body:Container(child: Card(child: FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot){
          if(snapshot.data==null){
            return Container
            (child: Center(
              child: Text('Loading...'),
              ),
              );
          }else return ListView.builder(
            itemCount: snapshot.data.length,
           itemBuilder: (context, i){
            return ListTile(
              title: Text(snapshot.data[i].category),
            );
          });
        },
      ),),
      ), 
    );
  }
}
class User{
  final String category;
  
  User(this.category);
}
