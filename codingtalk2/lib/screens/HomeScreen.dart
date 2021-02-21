import 'package:codingtalk2/screens/Drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String iduser;
  final String email;
  final String username;
  HomeScreen({this.iduser, this.email, this.username});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Drawerku(
            iduser: widget.iduser,
            email: widget.email,
            username: widget.username,
          ),
        ),
        appBar: AppBar(
          title: Text("Assalamualaikum"),
          backgroundColor: Colors.grey,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height / 3,
          child: Image.network(
              "https://i.pinimg.com/originals/37/78/30/37783071c79da4446a5ea591c859bcab.jpg"),
        ));
  }
}
