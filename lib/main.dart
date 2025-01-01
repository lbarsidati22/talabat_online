import 'package:flutter/material.dart';
import 'package:talabat_online/view/pages/nav_bar.dart';

void main() {
  runApp(const TalabatOnline());
}

class TalabatOnline extends StatelessWidget {
  const TalabatOnline({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Talabat-Online',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        useMaterial3: true,
        primaryColor: Color(0xff3700b3),
      ),
      home: NavBar(),
    );
  }
}
