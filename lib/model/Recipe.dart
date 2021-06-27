import 'dart:convert';

import 'package:team_queso/model/Client.dart' as cl;

class Recipe {
  int idRecipe;
  String name;
  int id;
  String type;
  String category;
  String image;
  String tutorial;
  int weather;
  int quantity;
  String ingredient;
  int steps;
  cl.Client client;
  bool favourite;

  void inicializar() {
    this.idRecipe = 0;
    this.name = "";
    this.id = 0;
    this.type = "";
    this.category = "";
    this.image = "";
    this.tutorial = "";
    this.weather = 0;
    this.quantity = 0;
    this.ingredient = "";
    this.steps = 0;
    this.client = new cl.Client(0, "", "", 0, "");
    this.favourite = false;
  }

  Recipe(
      {this.idRecipe,
      this.name,
      this.id,
      this.type,
      this.category,
      this.image,
      this.tutorial,
      this.weather,
      this.quantity,
      this.ingredient,
      this.steps,
      this.client,
      this.favourite});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
        idRecipe: json["_id"],
        name: json["name"],
        id: json["id"],
        type: json["type"],
        category: json["category"],
        image: json["image"],
        tutorial: json["tutorial"],
        weather: json["weather"],
        quantity: json["quantity"],
        ingredient: json["ingredient"],
        steps: json["steps"],
        client: json["client"],
        favourite: json["favourite"]);
  }
}
