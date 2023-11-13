import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/screens/auth/authenticate.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/parent_pages/home_parent.dart';
import 'package:ummicare/services/parentDatabase.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<userModel?>(context);

    if (user == null) {
      return const Authenticate();
    } else {
      return StreamProvider<parentModel?>.value(
        value: parentDatabase(parentId: user.userId).parentData,
        initialData: null,
        catchError: (_,__) {
          return null;
        },
        child: HomeParent(),
      );
    }
  }
}
