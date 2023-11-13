import 'package:flutter/material.dart';
import 'package:ummicare/routes.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<userModel?>.value(
      value: AuthService().user,
      initialData: null,
      catchError: (_,__) {},
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'ABeeZee'),
        routes: routes,
        initialRoute: '/',
      ),
    );
  }
}
