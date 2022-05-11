import 'dart:ui';

import 'package:flutter/material.dart';

class Componentes {

  static rotulo(String rotulo) {
    return Text(rotulo, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),);
  }

  static caixaDeTexto(
      String rotulo, String dica, TextEditingController controlador, valicao, {bool obscure = false, bool numero = false}) {
    return TextFormField(
      controller: controlador,
      obscureText: obscure,
      validator: valicao,
      keyboardType: numero ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: rotulo,
        border: InputBorder.none,
        labelStyle: TextStyle(fontSize: 20, color: Colors.blue),
        hintText: dica,
        hintStyle: TextStyle(fontSize: 15, color: Colors.blue),
      ),
    );
  }
}