import 'package:flutter/material.dart';
import 'package:march_card/home_page.dart';

void main() {
  runApp(const MarchApp());
}

class MarchApp extends StatelessWidget {
  const MarchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
