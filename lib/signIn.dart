import 'package:app/userBlock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'signUp.dart';
import 'dart:async';
import 'home.dart';
import 'constant.dart';
import 'package:dio/dio.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  final _controllerUserName = TextEditingController();
  final _controllerPassword = TextEditingController();
  var data;
  var dio = Dio();
  final error = SnackBar(content: Text('Failed To Login :('));

  void initState() {
    super.initState();
  }

  Future login() async {
    try {
      print(url);
      final response = await dio.post(url + 'user/login', data: {
        'userName': _controllerUserName.text.toString(),
        'password': _controllerPassword.text.toString()
      });

      if (response.statusCode == 200) {
        final UserBlock userBlock = Provider.of(context, listen: false);

        // add your code here.

        // If the server did return a 200 OK response,
        // then parse the JSON.
        setState(() {
          data = response.data;
        });
        if (data != null) {
          await userBlock.setUser(data);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(error);
    }
  }

  void dispose() {
    _controllerUserName.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(data);
    return Scaffold(
      backgroundColor: Color(0xFFFA98D9),
      body: Center(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/girl.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(top: 250),
                width: double.infinity,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 20, 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: _controllerUserName,
                          // The validator receives the text that the user has entered.
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            icon: Icon(Icons.person),
                            labelText: 'User Name',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            hintText: 'User Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 20, 20),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          obscureText: true,
                          controller: _controllerPassword,
                          // The validator receives the text that the user has entered.
                          decoration: const InputDecoration(
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            icon: Icon(Icons.lock),
                            labelText: 'Password',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            hintText: 'Password',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            login();

                            print(_controllerUserName.text);
                            print(_controllerPassword.text);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          child: Text('Sign In'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 60, 0, 10),
                        child: Text(
                          'dont have a account ?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUp(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            child: Text('Sign Up'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// }
