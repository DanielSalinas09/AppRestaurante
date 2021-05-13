import 'package:app_restaurante/src/preferencias_usuario/preferencias.dart';
import 'package:app_restaurante/src/providers/CarritoProvider.dart';

import 'package:app_restaurante/src/providers/pedidoProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';

void main() => runApp(PagosOnline());

class PagosOnline extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PagosOnlineState();
  }
}

class PagosOnlineState extends State<PagosOnline> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final pedidoProvider = new PedidoProvider();
  final _prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    final carritoProvider =
        Provider.of<CarritoProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Pago en linea",
            style: TextStyle(color: Color(0xFF7575753)),
          ),
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF7575753)),

          shadowColor: Colors.white,

          backgroundColor: Colors.white,
          centerTitle: true,
          // color
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  CreditCardWidget(
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cardBgColor: Color(0xD3E44646),
                    cvvCode: cvvCode,
                    showBackView: isCvvFocused,
                    obscureCardNumber: true,
                    obscureCardCvv: true,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        CreditCardForm(
                          numberValidationMessage:
                              "Ingrese un numero de tarjeta valido",
                          dateValidationMessage: "ingrese fecha valida",
                          cvvValidationMessage: "ingrese cvv valido",
                          formKey: formKey,
                          obscureCvv: true,
                          obscureNumber: false,
                          cardHolderDecoration: const InputDecoration(
                            labelText: 'Nombre de titular',
                          ),
                          cardNumberDecoration: const InputDecoration(
                            labelText: 'Numero',
                            hintText: 'XXXX XXXX XXXX XXXX',
                          ),
                          expiryDateDecoration: const InputDecoration(
                            labelText: 'Fecha de expiracion',
                            hintText: 'MM/YY',
                          ),
                          cvvCodeDecoration: const InputDecoration(
                            labelText: 'CVV',
                            hintText: 'XXX',
                          ),
                          onCreditCardModelChange: onCreditCardModelChange,
                        ),
                        _button(context, carritoProvider),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  Widget _button(BuildContext context, CarritoProvider carritoProvider) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color(0xF2EB1515), elevation: 5),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 15.0, 40.0, 15.0),
              child: Text(
                'Pagar',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            onPressed: () {
              if (formKey.currentState.validate()) {
                _realizarPedido(carritoProvider);
              } else {
                print('invalid!');
              }
            }),
      ),
    );
  }

  _realizarPedido(
    CarritoProvider carritoProvider,
  ) async {
    carritoProvider.realizarPedido();
    if (_prefs.idDirection == null) {
      _mostrarAlert();
      print("Entro aqui");
    } else {
      print("Direccion: " + _prefs.idDirection);
      Map info = await pedidoProvider.pedido(_prefs.token, _prefs.idUsuario,
          _prefs.idDirection, carritoProvider.datos);

      if (info["message"] == "pedido guardada correctametne") {
        _prefs.idPedido = info["pedido"]["_id"];
        _prefs.estado = info["pedido"]["estado"];
        print("El id del pedido" + _prefs.idPedido);
        Navigator.pushNamed(context, 'sendingOrder');
      } else {
        _mostrarAlert();
        print("Entro aqui 2");
      }
    }
  }

  void _mostrarAlert() {
    showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Informacion incorrecta',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            content: Text(
              "El pedido no ha sido efectuado verifique la direccion",
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              TextButton(
                child: Text('Ok', style: TextStyle(fontSize: 20)),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }
}
