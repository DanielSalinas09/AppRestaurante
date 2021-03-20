import 'package:flutter/material.dart';

class ReviewOrder extends StatefulWidget {
  ReviewOrder({Key key}) : super(key: key);

  @override
  _ReviewOrderState createState() => _ReviewOrderState();
}

class _ReviewOrderState extends State<ReviewOrder> {
  int _value = 1;
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
          'Revision de orden',
          style: TextStyle(
              fontSize: 27,
              color: Color(0xF2979797),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title('Pedido #1', 'Hamburguesa'),
            _body('Cra 46 # 53 - 130', '10:00pm', '75.800')
          ],
        ),
      ),
      bottomNavigationBar: _button(context),
    );
  }

  Widget _button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color(0xF2EB1515), elevation: 5),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Confirmar pedido',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            onPressed: () {
              switch (_value) {
                case 1:
                  Navigator.pushNamed(context, 'sendingOrder');
                  break;
                case 2:
                  Navigator.pushNamed(context, 'pagosOnline');
                  break;
                default:
              }
            }),
      ),
    );
  }

  Widget _title(String nOrder, String category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          nOrder,
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        Text(
          category,
          style: TextStyle(fontSize: 20, color: Color(0xF2979797)),
        )
      ],
    );
  }

  Widget _body(String direction, String tiempo, String valor) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Direccion',
        style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
      ),
      InkWell(
        onTap: () {},
        child: Container(
          height: 60,
          padding: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
              color: Color(0xCBE6E3E3),
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(direction,
                  style: TextStyle(
                    fontSize: 18,
                  )),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        'Tiempo de envio',
        style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
      ),
      InkWell(
        onTap: () {},
        child: Container(
          width: double.infinity,
          height: 60,
          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
          decoration: BoxDecoration(
              color: Color(0xCBE6E3E3),
              borderRadius: BorderRadius.circular(15)),
          child: Text('Entrega ' + tiempo,
              style: TextStyle(
                fontSize: 18,
              )),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        'Metodo de Pago',
        style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
      ),
      InkWell(
        onTap: () {},
        child: Container(
          height: 60,
          padding: EdgeInsets.only(right: 15, top: 15),
          decoration: BoxDecoration(
              // color: Color(0xCBE6E3E3),
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: DropdownButton(
                    value: _value,
                    items: [
                      DropdownMenuItem(
                        child: Text("pago Contra entrega",
                            style: TextStyle(
                              fontSize: 18,
                            )),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text(
                          "pago online",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        value: 2,
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    }),
              ),
              // Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 25,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total ',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Icon(Icons.attach_money),
              Text(
                valor,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      )
    ]);
  }
}
