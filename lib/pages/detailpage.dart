import 'package:flutter/material.dart';
import 'package:team_queso/listviewuser.dart';
import 'package:team_queso/pages/NewRecipe.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.index, this.list});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  _navigateList(BuildContext context) async {}

  Future<http.Response> removeRecipe(String id) async {
    var url = 'https://api-recetas-moviles.herokuapp.com/api/recetas/$id';

    var response = await http
        .delete(Uri.parse(url), headers: {"Content-Type": "application/json"});
    print("${response.statusCode}");
    return response;
  }

  //create function delete
  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Esta seguro de eliminar '${widget.list[widget.index]['_id']}'?"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text(
            "Si!",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.red,
          onPressed: () {
            removeRecipe(widget.list[widget.index]['_id'].toString());
            _navigateList(context);
          },
        ),
        new RaisedButton(
          child: new Text("No", style: new TextStyle(color: Colors.black)),
          color: Colors.green,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar:
      //     new AppBar(title: new Text("${widget.list[widget.index]['name']}")),
      body: new Container(
        height: 1000.0,
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(top: 30.0),
              ),
              new Text(
                widget.list[widget.index]['name'],
                style: new TextStyle(fontSize: 20.0),
              ),
              Divider(),
              new Text(
                "Tipo : ${widget.list[widget.index]['type']}",
                style: new TextStyle(fontSize: 18.0),
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  children: [
                    Container(
                      child: Image.network(
                        widget.list[widget.index]['image'],
                        width: 300,
                        height: 200,
                      ),
                    ),
                  ],
                ),
              ),
              new Text(
                "Tutorial : ${widget.list[widget.index]['tutorial']}",
                style: new TextStyle(fontSize: 18.0),
              ),
              new Text(
                "Tiempo : ${widget.list[widget.index]['weather']} min",
                style: new TextStyle(fontSize: 18.0),
              ),
              new Text(
                "Ingredientes : ${widget.list[widget.index]['ingredients']}",
                style: new TextStyle(fontSize: 18.0),
              ),
              new Text(
                "Pasos : ${widget.list[widget.index]['steps']}",
                style: new TextStyle(fontSize: 18.0),
              ),
              new Text(
                "Pasos : ${widget.list[widget.index]['steps']}",
                style: new TextStyle(fontSize: 18.0),
              ),
              new Text(
                "Nombre del cliente : ${widget.list[widget.index]['nameClient']}",
                style: new TextStyle(fontSize: 18.0),
              ),
              new Text(
                "Email del cliente : ${widget.list[widget.index]['email']}",
                style: new TextStyle(fontSize: 18.0),
              ),
              new Text(
                "Edad del cliente : ${widget.list[widget.index]['age']}",
                style: new TextStyle(fontSize: 18.0),
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 30.0),
              ),
              new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new RaisedButton(
                      child: new Text("Edit"),
                      color: Colors.blueAccent,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute<Null>(
                            builder: (BuildContext pContext) {
                          return new NewRecipe(
                            "Editar Recetar",
                            widget.list[widget.index]['_id'].toString(),
                            widget.list,
                            widget.index,
                          );
                        }));
                      }),
                  VerticalDivider(),
                  new RaisedButton(
                    child: new Text("Delete"),
                    color: Colors.redAccent,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: () => confirm(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
