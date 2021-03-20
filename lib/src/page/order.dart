import 'package:flutter/material.dart';

class OrderProduct extends StatefulWidget {
  OrderProduct({Key key}) : super(key: key);

  @override
  _OrderProductState createState() => _OrderProductState();
}

class _OrderProductState extends State<OrderProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xF2979797)),
          title: Text(
            'Orden',
            style: TextStyle(
                fontSize: 27,
                color: Color(0xF2979797),
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            _orden('Hamburguesa sencilla','miercoles, 21 de marzo', '75.800'),
            _orden('Perro suizo','miercoles, 21 de marzo', '15.800'),
             _orden('Salchipapa','miercoles, 21 de marzo', '25.800'),
          ],),
        ),

    );
  }

 Widget _orden(String nombre, String fecha, String valor) {
   return Column(
     children: [
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
             Container(
               width: 150,
               child: Text(nombre,
               style: TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.bold
               ),
               ),
             ),
             Container(
               width: 180,
               child: Text(fecha,
               style: TextStyle(
                 fontSize: 18,
                 color: Color(0xFFCACACAf),
                 ),
               ),
             )

           ],),
           Row(children: [
             Icon(Icons.attach_money, size: 22,),
             Text(valor,
             style: TextStyle(
               fontSize: 20,
               fontWeight: FontWeight.bold
               ),
             )

           ], ),
           

       ],),
       SizedBox(height: 5, ),
       Divider()
     ],
   );
 }
}