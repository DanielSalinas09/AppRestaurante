import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

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

  @override
  Widget build(BuildContext context) {
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
                        _button(context),
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
              padding: const EdgeInsets.fromLTRB(40.0, 15.0, 40.0, 15.0),
              child: Text(
                'Pagar',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            onPressed: () {
              if (formKey.currentState.validate()) {
                Navigator.popAndPushNamed(context, 'sendingOrder');
              } else {
                print('invalid!');
              }
            }),
      ),
    );
  }
}
