import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'componentes.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController txtAcao = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  double price = 0.00;
  String nomeCompany = "";

  Function validaAcao = ((value) {
    if (value.isEmpty) {
      return "Ação inválida";
    }
    return null;
  });

  clicouBotao() async {
    Uri url = Uri.parse("https://api.hgbrasil.com/finance/stock_price?key=eaea954c&symbol=${txtAcao.text}");

    Response resposta = await get(url);
    Map bolsa = json.decode(resposta.body);
    setState(() {
      price = bolsa["results"][txtAcao.text.toUpperCase()]["price"];
      nomeCompany = bolsa["results"][txtAcao.text.toUpperCase()]["company_name"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: keyForm,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: new BoxDecoration(color: Colors.blue),
                padding: EdgeInsets.only(top: 20),
                child: Image.asset(
                  "assets/imgs/bolsa_valores.png",
                  fit: BoxFit.contain,
                ),
              ),
              Componentes.caixaDeTexto(
                  "Ação", "Informe a ação", txtAcao, validaAcao),
              Container(
                decoration: new BoxDecoration(color: Colors.blue),
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Componentes.rotulo(" "),
                    Componentes.rotulo(
                        "Valor da Ação: BRL " + price.toString() + ""),
                    Componentes.rotulo("Cia: " + nomeCompany),
                  ],
                ),
              ),
              Container(
                decoration: new BoxDecoration(color: Colors.blue),
                alignment: Alignment.center,
                height: 100,
                child: IconButton(
                  onPressed: clicouBotao,
                  icon: FaIcon(
                    FontAwesomeIcons.moneyBill,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}