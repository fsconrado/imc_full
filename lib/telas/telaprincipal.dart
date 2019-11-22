import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {

  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();

  String _infoText = "Informe seus Dados!";

  GlobalKey<FormState> _chaveGlobal = GlobalKey<FormState>();

  void _resetDados() {
    alturaController.text = "";
    pesoController.text = "";
    setState(() {
      _infoText = "Informe seus Dados!";
      _chaveGlobal = GlobalKey<FormState>();
    });
  }

  void _calcular() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);

      if (imc < 18.5) {
        _infoText = "Abaixo do peso: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 18.5 && imc < 25) {
        _infoText = "Peso Ideal: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 25 && imc < 30) {
        _infoText = "Levemente acima do peso: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 30 && imc < 35) {
        _infoText = "Obesidade Grau I: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 35 && imc < 40) {
        _infoText = "Obesidade Grau II: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III: ${imc.toStringAsPrecision(3)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetDados,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _chaveGlobal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                color: Colors.green,
                size: 150,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso(kg):",
                    labelStyle: TextStyle(color: Colors.green, fontSize: 25)),
                textAlign: TextAlign.center,
                controller: pesoController,
                validator: (valor){
                  if(valor.isEmpty){
                    return "Insira seu peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura(cm):",
                    labelStyle: TextStyle(color: Colors.green, fontSize: 25)),
                textAlign: TextAlign.center,
                controller: alturaController,
                validator: (valor){
                  if(valor.isEmpty){
                    return "Insira sua Altura!";
                  }
                },
              ),
              Container(
                height: 70,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: RaisedButton(
                  child: Text(
                    "Calcular",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  color: Colors.green,
                  onPressed: (){
                    if(_chaveGlobal.currentState.validate())
                    _calcular();
                  },
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 23),
              )
            ],
          ),
        ),
      ),
    );
  }
}
