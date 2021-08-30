import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zim_birds/src/home_page.dart';
import 'package:zim_birds/src/services/bird_service.dart';
import 'package:zim_birds/src/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting)
            return Material(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          return MultiProvider(
            providers: [ChangeNotifierProvider(create: (_) => BirdService())],
            builder: (context, snapshot) {
              return MaterialApp(
                title: 'Zim Birds',
                theme: appTheme(),
                home: HomePage(),
              );
            },
          );
        });
  }
}
