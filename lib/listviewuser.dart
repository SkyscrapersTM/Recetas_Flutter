import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:team_queso/pages/NewRecipe.dart';
import 'package:team_queso/pages/detailpage.dart';

class ListUsers extends StatefulWidget {
  @override
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  List data;
  Future<List> getData() async {
    String url = 'https://api-recetas-moviles.herokuapp.com/api/recetas/';
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  void _loadPageRecipe() {
    Navigator.of(context)
        .push(new MaterialPageRoute<Null>(builder: (BuildContext pContext) {
      return new NewRecipe("Nueva Receta", "", null, 0);
    }));
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Recetas"),
        actions: [
          IconButton(
              icon: Icon(
                Icons.post_add_sharp,
                color: Colors.black,
              ),
              onPressed: _loadPageRecipe),
        ],
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ItemList(
                  list: snapshot.data,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;

  const ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Column(
          children: [
            Container(
                padding: EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Detail(
                              list: list,
                              index: i,
                            )),
                  ),
                  child: Container(
                    height: 415.3,
                    child: Card(
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    'Plato: ' + list[i]['name'].toString(),
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.black87),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    'categoria: ' +
                                        list[i]['category'].toString(),
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.black87),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    'Tiempo de preparacion: ' +
                                        list[i]['weather'].toString() +
                                        ' min.',
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.black87),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Container(
                                  child: Image.network(
                                    list[i]['image'],
                                    width: 300,
                                    height: 200,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        );
      },
    );
  }
}
