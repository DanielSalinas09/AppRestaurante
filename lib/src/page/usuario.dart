import 'package:flutter/material.dart';

class Usuario extends StatefulWidget {
  Usuario({Key key}) : super(key: key);

  @override
  _UsuarioState createState() => _UsuarioState();
}

class _UsuarioState extends State<Usuario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xEEEEEEEEEE),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0))),
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Image.asset(
                  'assets/img/logo.jpg',
                  height: 200,
                )),
                Center(
                    child: Text(
                  'USUARIO',
                  style: TextStyle(fontFamily: 'Chonburi', fontSize: 20),
                )),
                Center(
                    child: Text('Nombre usuario',
                        style:
                            TextStyle(fontFamily: 'Chonburi', fontSize: 20))),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(7.0),
                      margin: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Historial de pedidos ',
                            style: TextStyle(
                                fontSize: 18.0, fontFamily: 'Chonburi'),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                    onTap: () =>
                        {Navigator.pushNamed(context, 'historialPedidos')},
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(7.0),
                      margin: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Configuracion             ',
                            style: TextStyle(
                                fontSize: 18.0, fontFamily: 'Chonburi'),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                    onTap: () =>
                        {Navigator.pushNamed(context, 'configuracion')},
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(7.0),
                      margin: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Cerrar sesión              ',
                            style: TextStyle(
                                fontSize: 18.0, fontFamily: 'Chonburi'),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                    onTap: () => {Navigator.pushNamed(context, 'login')},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
