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
    var url = 'https://24c758245aa2.ngrok.io/api/recetas/$id';

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
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: <Widget>[
                    Container(
                      // A fixed-height child.
                      color: Colors.white,
                      height: 130.0,
                      alignment: Alignment.center,
                      child: Text(
                        " \n ${widget.list[widget.index]['name']}",
                        style: new TextStyle(fontSize: 30.0),
                      ),
                    ),
                    Expanded(
                      // A flexible child that will grow to fit the viewport but
                      // still be at least as big as necessary to fit its contents.
                      child: Container(
                        color: Colors.white, // Red
                        height: 960.0,
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            new Text("\n"),
                            new Image.network(
                              widget.list[widget.index]['image'],
                              width: 300,
                              height: 200,
                            ),
                            new Text("\n"),
                            new Text(
                              "Tutorial : ${widget.list[widget.index]['tutorial']}",
                              style: new TextStyle(fontSize: 18.0),
                            ),
                            new Text(
                              "Tiempo : ${widget.list[widget.index]['weather']} min",
                              style: new TextStyle(fontSize: 18.0),
                            ),
                            new Text("\n"),
                            new Text(
                              "Ingredientes : ${widget.list[widget.index]['ingredient']}",
                              style: new TextStyle(fontSize: 18.0),
                            ),
                            new Text(""),
                            new Text(
                              "Pasos : ${widget.list[widget.index]['steps']}",
                              style: new TextStyle(fontSize: 18.0),
                            ),
                            new Text("\n"),
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
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          new MaterialPageRoute<Null>(
                                              builder: (BuildContext pContext) {
                                        return new NewRecipe(
                                          "Editar Recetar",
                                          widget.list[widget.index]['_id']
                                              .toString(),
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
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                  onPressed: () => confirm(),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
