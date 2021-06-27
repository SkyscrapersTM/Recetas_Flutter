import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart' show Future;
import 'package:team_queso/model/Client.dart';
import 'package:team_queso/model/Recipe.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart' show Future;

class NewRecipe extends StatefulWidget {
  String titulo = "";
  Recipe orecipe = new Recipe();
  int codigoRecipeSeleccionado = 0;
  String urlGeneral = 'https://api-recetas-moviles.herokuapp.com/api/recetas/';

  String mensaje = "";
  bool validacion = false;
  NewRecipe(this.titulo, this.codigoRecipeSeleccionado);

  @override
  _NewRecipe createState() => _NewRecipe();
}

class _NewRecipe extends State<NewRecipe> {
  final _tfNameRecipe = TextEditingController();
  final _tfType = TextEditingController();
  final _tfCategory = TextEditingController();
  final _tfImage = TextEditingController();
  final _tftutorial = TextEditingController();
  final _tfWheater = TextEditingController();
  final _tfQuanty = TextEditingController();
  final _tfIngredient = TextEditingController();
  final _tfSteps = TextEditingController();
  final _tfNameClient = TextEditingController();
  final _tfEmailClient = TextEditingController();
  final _tfAgeClient = TextEditingController();

  void initState() {
    super.initState();
  }

  Future<String> _ejecutarServicio() async {
    Map data = {
      "name": _tfNameRecipe.text,
      "receta": [
        {
          "id": 1,
          "type": _tfType.text,
          "category": _tfCategory.text,
          "image": _tfImage.text,
          "tutorial": "https://youtu.be/xQsPiAf-t1Q",
          "weather": _tfWheater.text,
          "ingredients": [
            {
              "id": 1,
              "quantity": _tfQuanty.text,
              "ingredient": _tfIngredient.text
            }
          ],
          "preparation": [
            {"id": 1, "steps": _tfSteps.text}
          ],
          "client": [
            {
              "id": 1,
              "nameClient": _tfNameClient.text,
              "email": _tfEmailClient.text,
              "age": _tfAgeClient.text,
              "pass": "1234"
            }
          ],
          "favourite": true
        }
      ]
    };

    String body = json.encode(data);

    var url = Uri.parse(widget.urlGeneral);
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return "Procesado";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de Servicios " + widget.titulo),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
                "Código de cliente: " + widget.orecipe.idRecipe.toString()),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              children: <Widget>[
                TextField(
                    controller: _tfNameRecipe,
                    decoration: InputDecoration(
                      hintText: "Ingresar Nombre de la Receta",
                      labelText: "Nombre del Receta",
                    )),
                TextField(
                    controller: _tfType,
                    decoration: InputDecoration(
                      hintText: "Ingrese el tipo de receta",
                      labelText: "Tipo",
                    )),
                TextField(
                    controller: _tfCategory,
                    decoration: InputDecoration(
                      hintText: "Ingrese la Categoria",
                      labelText: "Categoria",
                    )),
                TextField(
                    controller: _tfImage,
                    decoration: InputDecoration(
                      hintText: "Ingrese imagen",
                      labelText: "Imagen",
                    )),
                TextField(
                    controller: _tftutorial,
                    decoration: InputDecoration(
                      hintText: "Ingresar el video tutorial",
                      labelText: "Video tutorial",
                    )),
                TextField(
                    controller: _tfWheater,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: false),
                    decoration: InputDecoration(
                      hintText: "Ingresar el tiempo de preparación",
                      labelText: "Tiempo de Preparación",
                    )),
                TextField(
                    controller: _tfQuanty,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: false),
                    decoration: InputDecoration(
                      hintText: "Ingresar la cantidad de ingredientes",
                      labelText: "Cantidad",
                    )),
                TextField(
                    controller: _tfIngredient,
                    decoration: InputDecoration(
                      hintText: "Ingresar los ingredientes",
                      labelText: "Ingredientes",
                    )),
                TextField(
                    controller: _tfSteps,
                    decoration: InputDecoration(
                      hintText: "Ingresar los pasos de preparación",
                      labelText: "Preparación",
                    )),
                TextField(
                    controller: _tfNameClient,
                    decoration: InputDecoration(
                      hintText: "Ingresar el nombre del cliente",
                      labelText: "Nombre Cliente",
                    )),
                TextField(
                    controller: _tfEmailClient,
                    decoration: InputDecoration(
                      hintText: "Ingresar el email del cliente",
                      labelText: "Email",
                    )),
                TextField(
                    controller: _tfAgeClient,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: false),
                    decoration: InputDecoration(
                      hintText: "Ingresar la edad de cliente",
                      labelText: "Edad del cliente",
                    )),
                RaisedButton(
                  color: Colors.grey[500].withOpacity(0.7),
                  child: Text(
                    "Grabar",
                    style: TextStyle(fontSize: 18, fontFamily: "rbold"),
                  ),
                  onPressed: _ejecutarServicio,
                ),
                Text("Mensaje: " + widget.mensaje),
              ],
            ),
          )
        ],
      ),
    );
  }
}
