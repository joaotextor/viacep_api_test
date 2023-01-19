import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/*StatefulWidget is a widget that has a mutable state. 

It is the responsibility of the widget implementer to ensure that the State is promptly notified when such state changes, using State.setState.

A stateful widget a widget that describes part of the user interface by building a constellation of other widgets that describe the user interface more concretely. The building process continues recursively until the description of the user interface is fully concrete (e.g., consists entirely of RenderObjectWidgets, which describe concrete RenderObjects).

*/

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController txtcep = new TextEditingController();
  String resultado = '';

  _consultaCep() async {
    String cep = txtcep.text;
    String url = "https://viacep.com.br/ws/${cep}/json/";
    http.Response response;
    response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = json.decode(response.body);

    String logradouro = retorno["logradouro"];
    String cidade = retorno["localidade"];
    String bairro = retorno["bairro"];
    String UF = retorno["uf"];

    setState(() {
      resultado = "${logradouro}, ${bairro}, ${cidade}/${UF}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consulta de CEP com API"),
        backgroundColor: Colors.amber[900]
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite o CEP. Somente números.",
              ),
              style: TextStyle(fontSize: 15),
              controller: txtcep,
            ),
            Text(
            "Resultado: ${resultado}",
            style: TextStyle(fontSize: 25),
            ),
            ElevatedButton(
              child: Text(
                "Consultar",
                style: TextStyle(fontSize: 15),
              ),
              onPressed: _consultaCep,
            ),
          ],
        )),
    );
  }
}