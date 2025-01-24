import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool  _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      // appBar: AppBar(
      //   title: Text('Proyecto Final'),
      // ),
      body: Stack (
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 60),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors :[Color(0x8B84A9F3),
                      Color(0x8B46A1E7),
                      Color(0x8B0266FC),]
                )
              ),
            child: Image.asset("assets/images/userLogin.png",
              height: 250,
              ),
          ),
          Center(
            child: Card (
              margin: const EdgeInsets.only(left: 30, right: 20, top: 260),
              //alt Enter
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                child: Column (
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Usuario',
                      ),
                    ),
                  SizedBox(height: 40,),
                  TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                      ),
                    obscureText: true,
                  ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          // foregroundColor: Theme.of(context).hintColor,
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.cyan,
                      ),
                      onPressed:() {
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Iniciar Sesión'),
                              // if (_loading)
                              /*Container(
                                height: 20,
                                width: 20,
                                margin: const EdgeInsets.only(left: 20),
                                child: CircularProgressIndicator(),
                              )*/
                            ],
                      )
                    )
                  ]
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}