import 'dart:ffi';

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
  TextEditingController txtUf = new TextEditingController();
  TextEditingController txtCidade = new TextEditingController();
  TextEditingController txtLogradouro = new TextEditingController();
  List resultado = [];

  _consultaCep() async {
    String uf = txtUf.text;
    String cidade = txtCidade.text;
    String logradouro = txtLogradouro.text;
    String url = "https://viacep.com.br/ws/${uf}/${cidade}/${logradouro}/json/";
    String cep = '';
    http.Response response;
    response = await http.get(Uri.parse(url));

    List<dynamic> retorno = json.decode(response.body);

    retorno.forEach((element) {
      cep = element["cep"];
      resultado.add(cep);
    });


    setState(() {});
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
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Digite a UF",
              ),
              style: TextStyle(fontSize: 15),
              controller: txtUf,
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Digite a cidade",
              ),
              style: TextStyle(fontSize: 15),
              controller: txtCidade,
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Digite o logradouro",
              ),
              style: TextStyle(fontSize: 15),
              controller: txtLogradouro,
            ),
            new Expanded(
              child: new ListView.builder(
                  itemCount: resultado.length,
                  itemBuilder: (BuildContext ctxt, int Index) {
                    return new Text(resultado[Index]);
                  },
              ),
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