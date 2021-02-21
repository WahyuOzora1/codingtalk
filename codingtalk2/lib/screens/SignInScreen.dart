import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'SignUpScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomeScreen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController password1 = TextEditingController();
  TextEditingController email = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future loginAccount() async {
    var url = "http://192.168.10.39/codingtalk2/signin.php";
    final responseData = await http.post(url, body: {
      "email": email.text,
      "password1": password1.text,
    });

    var data = json.decode(responseData.body);

    if (responseData.statusCode == 200) {
      if (data['message'] == "Success") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("email", data['body']['email']);
        prefs.setString("id_user", data['body']['id_user']);
        prefs.setString("username", data['body']['username']);

        Fluttertoast.showToast(
          msg: "Login Berhasil",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => HomeScreen(
                    iduser: data['body']['id_user'], //body itu $row dalam php
                    email: data['body']['email'],
                    username: data['body']['username'])));
      } else {
        Fluttertoast.showToast(
            msg: "Username dan Password tidak sesuai",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
    return data;
  }

  Future<void> checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email");
    String username = prefs.getString("username");
    String idUser = prefs.getString("id_user");
    // await prefs.clear();
    // prefs.remove("username");
    if (email != null && username != null && idUser != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => HomeScreen(
                  iduser: idUser, //body itu $row dalam php
                  email: email,
                  username: username)));
    }
  }

  checkForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      loginAccount();
    }
  }

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('asset/img/sign.jpg'))),
                child: Positioned(
                    child: Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'SELAMAT DATANG SOBAT SANTUY😊',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    )
                  ],
                )),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.mail), onPressed: null),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(right: 20, left: 10),
                            child: TextFormField(
                              autovalidate: false,
                              controller: email,
                              onSaved: (String email) {
                                email = email;
                              },
                              decoration: InputDecoration(hintText: 'Email'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Email tidak boleh kosong';
                                } else if (value.length < 5) {
                                  return 'Email tidak boleh kurang dari 5 digit';
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return 'Masukkan email dengan benar';
                                }

                                return null;
                              },
                            )))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.lock), onPressed: null),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(right: 20, left: 10),
                            child: TextFormField(
                              autovalidate: false,
                              controller: password1,
                              decoration: InputDecoration(hintText: 'Password'),
                              obscureText: true,
                              onSaved: (value) {
                                password1.text = value;
                              },
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                } else if (value.length < 5) {
                                  return 'Passwordl tidak boleh kurang dari 5 digit';
                                }
                                return null;
                              },
                            ))),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: 60,
                    child: MaterialButton(
                      onPressed: () async {
                        await checkForm();
                      },
                      color: Colors.blue[900],
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Center(
                  child: RichText(
                    text: TextSpan(
                        text: 'Don\'t have an account?',
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: ' SIGN UP',
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
