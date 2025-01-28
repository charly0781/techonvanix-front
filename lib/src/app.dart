import 'package:flutter/material.dart';
import 'package:techonvanix/src/page/errorpage/NotFoundPage.dart';
import 'package:techonvanix/src/page/home/homePage.dart';
import 'package:techonvanix/src/page/home/login/loginPage.dart';
import 'package:techonvanix/src/page/home/userpage/UserPage.dart';
import 'package:techonvanix/src/process/dto/GlobalData.dart';

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
      initialRoute: '/home',
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) {
              print("router: " + settings.name.toString());
              switch (settings.name) {
                case '/home':
                  // return UserPage();
                  return HomePage();
                case '/userPage':
                  return  UserPage();
                default:
                  return NotFoundPage();
              }
            },
        );
      },
      routes: {
        '/home': (context) => const HomePage(),
        '/userPage': (context) =>  UserPage(),
        '/NotFoundPage': (context) => NotFoundPage(),
      },
    );
  }
}
