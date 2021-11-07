import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TelaHome extends StatefulWidget {
  const TelaHome({Key? key}) : super(key: key);

  @override
  _TelaHomeState createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  String _precoBitcoin = "0";

  _atualizarPreco() async {
    Uri url = Uri.parse("https://blockchain.info/ticker");
    http.Response response;

    try {
      response = await http.get(url);

      Map<String, dynamic> respostaApi = json.decode(response.body);
      setState(() {
        _precoBitcoin = respostaApi["BRL"]["buy"].toString();
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/bitcoin.png"),
            Padding(
              padding: EdgeInsets.only(top: 30, bottom: 30),
              child: Text(
                "R\$" + _precoBitcoin,
                style: TextStyle(fontSize: 25),
              ),
            ),
            RaisedButton(
              color: Colors.orange,
              child: Text(
                "Atualizar",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              padding: EdgeInsets.all(16),
              onPressed: _atualizarPreco,
            )
          ],
        ),
      ),
    );
  }
}
