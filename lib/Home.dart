import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController gitController = TextEditingController();
  String info_git = '';
  String img_url = '';

  _grabPerfil() async {
    String url = 'https://api.github.com/users/${gitController.text}';

    print(url);

    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> retorno = json.decode(response.body);
    int id = retorno["id"];
    String name = retorno["name"];
    int repo = retorno["public_repos"];
    String created_at = retorno["created_at"];
    int followers = retorno["followers"];
    int following = retorno["following"];

    setState(() {
      img_url = retorno["avatar_url"];
      info_git = ' ID: $id \n Nome: $name \n Repositórios: $repo  \n Criado em: $created_at \n Seguidores: $followers \n Seguindo: $following ';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Perfil dos DEVs'),
        ),
        backgroundColor: Colors.black.withOpacity(0.9),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              //FractionalOffset(0.3, 0.5),
              child: SizedBox(
                width: 225.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Digite o nome do Perfil", labelStyle: TextStyle(color: Colors.black.withOpacity(0.6))),
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 25.0),
                  controller: gitController,
                ),
              ),
            ),
            Align(
              alignment: FractionalOffset(0.98, 0.512),
              child: Container(
                height: 60.0,
                width: 60.0,
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                child: TextButton(
                  onPressed: _grabPerfil,
                  child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 20.0)),
                ),
              ),
            ),
            Align(
              alignment: FractionalOffset(0.0, 0.825),
              child: Text(
                info_git,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(width: 200, height: 200, child: Image.network('https://cdn-icons-png.flaticon.com/512/25/25231.png')),
            ),
            if (img_url != '')
              Align(
                alignment: Alignment.topCenter,
                child: Container(width: 200, height: 200, child: Image.network(img_url)),
              ),
          ],
        ),
      ),
    );
  }
}
