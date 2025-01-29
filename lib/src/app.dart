import 'package:flutter/material.dart';
import 'package:techonvanix/src/page/dinamicPage/AccountActivationPage.dart';
import 'package:techonvanix/src/page/dinamicPage/NotFoundPage.dart';
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
      initialRoute: '/home',
      onGenerateRoute: (RouteSettings settings) {
        List<String>? names = settings.name?.split('?').toList();
        // print("router: " + names.toString());

        switch (names?[0]) {
          case '/home':
            return MaterialPageRoute(builder: (context) => HomePage());

          case '/AccountActivation':
            String data = "";
            if (names!.length > 1) {
              data = names[1].replaceFirst("data=", "");
            }
            if (data.isNotEmpty) {
              print("arguments " + data);
              return MaterialPageRoute(
                builder: (context) => AccountActivationPage(
                  encryptedData: data
                ),
              );
            }
            return MaterialPageRoute(builder: (context) => NotFoundPage());

          default:
            return MaterialPageRoute(builder: (context) => NotFoundPage());
        }
      },
      routes: {
        '/home': (context) => const HomePage(),
        // '/userPage': (context) =>  UserPage(),
        '/NotFoundPage': (context) => NotFoundPage(),
        '/AccountActivation': (context) => AccountActivationPage(encryptedData: ""),
      },
    );
  }
}
