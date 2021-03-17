import 'package:flutter/material.dart';

class DescriptionDish extends StatefulWidget {
  DescriptionDish({Key key}) : super(key: key);

  @override
  _DescriptionDishState createState() => _DescriptionDishState();
}

class _DescriptionDishState extends State<DescriptionDish> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              color: Colors.black,
              icon: Icon(Icons.search),
              onPressed: () => Navigator.pushNamed(context, 'searchDireccion')),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _tituloProducto("Hamburguesa sencilla", 'barranquilla',
                  '10 - 20 min', '20.000', 'Hamburguesa'),
              SizedBox(height: 10),
              _bodyProducto(AssetImage('assets/img/burger.jpg')),
              SizedBox(height: 20),
              _ingrediente(
                  'Pan artesanal finas hierbas, doble carne de res (300 gr), jamon, tocineta ahumada, doble queso mozarella, salsas de la casa, vegetales frescos.')
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          _counterProduct(),
          _button('22.000', context),
        ],
      ),
    );
  }
}

Widget _ingrediente(String ingredientes) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INGREDIENTES',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            ingredientes,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Color(0xF2C9C9C9),
            height: 1,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              child: Row(
            children: [
              Icon(Icons.comment),
              Text(
                'Observación',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          )),
          SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 7,
            maxLength: 2000,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Ej: sin cebbolla, sin picante, mayonesa aparte, etc.',
            ),
          )
        ],
      ),
    ),
  );
}

Widget _button(String valor, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: BottomAppBar(
      elevation: 0,
      color: Colors.white,
      child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(primary: Color(0xF2EB1515), elevation: 5),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Text(
                'Agregar',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(Icons.attach_money),
              Text(
                valor,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.shopping_cart,
                size: 19,
              )
            ],
          ),
        ),
        onPressed: () => Navigator.pushNamed(context, 'carrito'),
      ),
    ),
  );
}

Widget _tituloProducto(String title, String ubicacion, String tiempo,
    String valor, String categoria) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.check_circle,
                color: Color(0xF2EB1515),
                size: 20,
              )
            ],
          ),
        ),
        Text(
          ubicacion,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xF2979797)),
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color(0xF2D6D4D4),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Icon(Icons.schedule),
                    Text(
                      tiempo,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xF2D6D4D4),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Icon(Icons.attach_money),
                    Text(
                      valor,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(
              color: Color(0xF2D6D4D4),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              categoria,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _bodyProducto(ImageProvider img) {
  return Column(
    children: [
      Container(
        height: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(image: img, fit: BoxFit.fill)),
      )
    ],
  );
}

Widget _counterProduct() {
  return Container(
    height: 60.0,
    margin: EdgeInsets.only(left: 5.0),
    decoration: BoxDecoration(
        color: Color(0x25979797), borderRadius: BorderRadius.circular(20)),
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          InkWell(
            child: Icon(
              Icons.remove,
              size: 30,
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
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            child: Icon(Icons.add, size: 30),
            onTap: () {
              print('max');
            },
          )
        ],
      ),
    ),
  );
}
