import 'package:flutter/material.dart';

import 'dart:async';
import 'package:dio/dio.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _controllerUserName = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerName = TextEditingController();
  final _controllerConfirmPassword = TextEditingController();
  var data;
  final userName = SnackBar(content: Text('User Name Taken'));
  final error = SnackBar(content: Text('Failed To Login :('));

  var dio = Dio();
  Future signup() async {
    final response = await dio.post(
      'http://192.168.0.100:4000/user/signup',
      data: {
        'name': _controllerName.text.toString(),
        'userName': _controllerUserName.text.toString(),
        'password': _controllerPassword.text.toString()
      },
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        },
      ),
    );

    if (response.statusCode == 200) {
      print('success full :)');
      login();
    } else if (response.statusCode == 409) {
      ScaffoldMessenger.of(context).showSnackBar(userName);
    } else {
      throw Exception('Failed :(');
    }
  }

  Future login() async {
    try {
      final response =
          await dio.post('http://192.168.0.101:4000/user/login', data: {
        'userName': _controllerUserName.text.toString(),
        'password': _controllerPassword.text.toString()
      });

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        setState(() {
          data = response.data['token'];
        });
        print(response.data['token']);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE1E9EB),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/man.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 170),
                        width: double.infinity,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  controller: _controllerName,
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
                                    labelText: 'Name',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    hintText: 'Name',
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
                                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
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
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
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
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  controller: _controllerPassword,
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
                                    icon: Icon(Icons.lock),
                                    labelText: 'Password',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
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
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 10, 20),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  controller: _controllerConfirmPassword,
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
                                    icon: Icon(Icons.lock),
                                    labelText: 'Confirm Password',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    hintText: 'Confirm Password',
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
                                    signup();
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 30),
                                  child: Text('Sign Up'),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 60, 0, 10),
                                child: Text(
                                  'Already have an account ?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 18,
                                    color: Colors.pink[500],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 30),
                                    child: Text('Sign In'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
  }
}
