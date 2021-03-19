import 'package:flutter/material.dart';


class ShoppingCart extends StatefulWidget {
  ShoppingCart({Key key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xF2979797)),
        centerTitle: true,
        title: Text('Tu canasta',
        style: TextStyle(
          fontSize: 22,
          color: Colors.black,
          fontWeight: FontWeight.bold
          ),
        ),
        ),
        body: Column(
          children: [
            _ordenes(AssetImage('assets/img/burger.jpg'),'Hamburguesa sencilla','22.000')

        ],),
    );
    
  }
}

Widget _ordenes(ImageProvider img, String nombre, String valor) {
  return Row(
    children: [
      Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: img, fit: BoxFit.fill)
          ),
        ),
        SizedBox(width: 20, ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(nombre,
          style: TextStyle(fontSize: 20),
          ),
          
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            
            children: [
              Icon(Icons.attach_money, size: 25,),
              Text(valor,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
                ),
              ),
            ],
          )
        ],
      ),
      Container(
        height: 40,

        decoration: BoxDecoration(
          color: Color(0xF2979797),
          borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
              InkWell(
                child: Icon(Icons.remove, size: 30,),
                onTap: (){print('menos'); },
                ),
              SizedBox(width: 15, ),
              Text('1',
              style: TextStyle(
                fontSize: 20
                ),
              ),
              SizedBox(width: 15, ),
              InkWell(
                child: Icon(Icons.add,size: 30),
                onTap: (){print('max');},
              )
              
            ],

            ),
          ),
        ),

    ],
  );
}