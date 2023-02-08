import 'package:flutter/material.dart';
import 'package:flutter_state_provider/controller/user_notifier.dart';
import 'package:flutter_state_provider/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserNotifier()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Color(0xFF2F5233)),
          primaryColor: const Color(0xFF2F5233),
          backgroundColor: const Color(0xFFDCDCDC)),
      home: Home(),
    );
  }
}
