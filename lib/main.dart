import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/home.dart';
import 'model/Event.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Event()),
        ],
        child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  final MaterialColor mycolor  = const MaterialColor(0xFF333A47, <int,Color>{
    50: Color(0xFF333A47),
    100: Color(0xFF333A47),
    200: Color(0xFF333A47),
    300: Color(0xFF333A47),
    400: Color(0xFF333A47),
    500: Color(0xFF333A47),
    600: Color(0xFF333A47),
    700: Color(0xFF333A47),
    800: Color(0xFF333A47),
    900: Color(0xFF333A47),
  });
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: mycolor,
          ),
          home: const MyHomePage()
      );
  }
}

