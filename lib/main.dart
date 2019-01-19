import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
 
void main() => runApp(new MyApp());
 
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(),
    );
  }
}
 
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage> {
  String url = 'http://192.168.0.105:5000/';
  List state = [-1, -1, -1, -1];
 
void getStatus(pin) async{
      try {
        Response response;
        Dio dio = new Dio(); // with default Options

        dio.options.baseUrl=url;
        response = await dio.post("status/", data: {"pin":pin});
		print(pin);
        setState((){
            state[pin-1] = json.decode(response.data)['status'];
            });
        return print(response.data);
      }catch(e){
        return print(e);
      }
 }

void togglePin(pin) async{
      try {
        Response response;// Set default configs
		Dio dio = new Dio();

        dio.options.baseUrl=url;
        response = await dio.post("toggle/", data: {"pin":pin});
        getStatus(pin);
        return;
      }catch(e){
        return print(e);
      }
 }

@override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Autopi"),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                '$state',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  fontFamily: 'Roboto',
                ),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () => togglePin(1),
                    child: new Text("Toggle : 1"),
                  ),
                  new RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () => togglePin(2),
                    child: new Text("Toggle : 2"),
                  ),
                  new RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () => togglePin(3),
                    child: new Text("Toggle : 3"),
                  ),
                  new RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () => togglePin(4),
                    child: new Text("Toggle : 4"),
                  ),
                  /* new RaisedButton( */
                  /*   onPressed: () => getStatus(4), */
                  /*   textColor: Colors.white, */
                  /*   color: Colors.red, */
                  /*   padding: const EdgeInsets.all(8.0), */
                  /*   child: new Text( */
                  /*     "Get status : 4", */
                  /*   ), */
                  /* ), */
                ],
              )
            ],
          ),
        ));
  }
}
