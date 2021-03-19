import 'package:flutter/material.dart';

class Carrito extends StatefulWidget {
  Carrito({Key key}) : super(key: key);

  @override
  _CarritoState createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
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
            'Carrito',
            style: TextStyle(
                fontSize: 30,
                color: Color(0xF2979797),
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView (
            child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(children: [
              _orden('Hamburguesa sencilla','miercoles, 21 de marzo', '75.800'),
              _orden('Perro suizo','miercoles, 21 de marzo', '15.800'),
               _orden('Salchipapa','miercoles, 21 de marzo', '25.800'),
               SizedBox( height: 300,),
               _button(context)
              

            ],),
          ),
        ),

    );
  }
  Widget _button(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: BottomAppBar(
      elevation: 0,
      color: Colors.white,
      child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(primary: Color(0xF2EB1515), elevation: 5),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Ir a pagar',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        onPressed: () => Navigator.pushNamed(context, 'checkout'),
      ),
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
             Text(nombre,
             style: TextStyle(
               fontSize: 22,
               fontWeight: FontWeight.bold
             ),
             ),
             

           ],),
           _counterProduct()

          
           

       ],),
       SizedBox(height: 5, ),
       Divider()
     ],
   );
 }
 Widget _counterProduct() {
  return Container(
    height: 45.0,
    margin: EdgeInsets.only(left: 5.0),
    decoration: BoxDecoration(
        color: Color(0x25979797), borderRadius: BorderRadius.circular(20)),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            child: Icon(
              Icons.remove,
              size: 20,
            ),
            onTap: () {
              print('menos');
            },
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            '1',
            style: TextStyle(fontSize: 23),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            child: Icon(Icons.add, size: 20),
            onTap: () {
              
            },
          )
        ],
      ),
    ),
  );
}

}