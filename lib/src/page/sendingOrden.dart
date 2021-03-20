import 'package:flutter/material.dart';

class SendingOrder extends StatefulWidget {
  SendingOrder({Key key}) : super(key: key);

  @override
  _SendingOrderState createState() => _SendingOrderState();
}

class _SendingOrderState extends State<SendingOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pedido",
          style: TextStyle(
                fontSize: 30,
                color: Color(0xF2979797),
                fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF7575753)),

        shadowColor: Colors.white,

        backgroundColor: Colors.white,
        centerTitle: true,
        // color
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Se esta preparando tu pedido',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                'Llegara en 10 - 20 min',
                style: TextStyle(fontSize: 19, color: Color(0xFF807E7E)),
              ),
              SizedBox(
                height: 15,
              ),
              _card(),
              SizedBox(
                height: 10,
              ),
              _lisView('10:00 PM', 'Cra 46# 53 -130')
            ],
          ),
        ),
      ),
    );
  }

  Widget _card() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: Color(0x88B1AEAE)),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Text(
            'Tu orden',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 100,
            decoration: BoxDecoration(
                color: Color(0xF2EB1515),
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text(
                    '10:00 pm',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Hora de entrega',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Text(
              'Con Take-Out Express, recibirá la entrega prioritaria de su pedido antes de las 10:00 pm, ¡o correremos por nuestra cuenta!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/carroExpress.jpg'))),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _lisView(String tiempo, String direcccion) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hora',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
        ),
        Text(
          tiempo,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        Text(
          'Garantizado',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF9B9999)),
        ),
        Divider(),
        Text(
          'Direccion',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
        ),
        Text(
          direcccion,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Detalles de la Orden ',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, 'order'),
              child: Text(
                'Ver \norden',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xF2EB1515)),
              ),
            )
          ],
        ),
        Divider()
      ],
    );
  }
}
