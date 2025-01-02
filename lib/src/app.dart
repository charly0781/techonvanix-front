import 'package:flutter/material.dart';
import 'package:techonvanix/src/page/home/homePage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TechonVanix ',
      theme: ThemeData(brightness: Brightness.light,
        primaryColor: Colors.blueGrey,
        hintColor: Colors.black,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return HomePage();
                default:
                  return HomePage();
              }
            }
        );
      },
    );
  }
}
