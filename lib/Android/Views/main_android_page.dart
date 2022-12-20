import 'package:flutter/material.dart';

class MainAndroidPage extends StatefulWidget {
  const MainAndroidPage({super.key});

  @override
  State<MainAndroidPage> createState() => _MainAndroidPageState();
}

class _MainAndroidPageState extends State<MainAndroidPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Main Android Page"),
      ),
    );
  }
}
