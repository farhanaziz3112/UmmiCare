import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/buddymodel.dart';
import 'package:ummicare/screens/parent_pages/buddy/registerBuddy.dart';
import 'package:ummicare/services/buddyDatabase.dart';

import '../../../models/childmodel.dart';
import '../../../models/usermodel.dart';
import '../../../services/database.dart';

class BuddyMain extends StatefulWidget {
  const BuddyMain({super.key});

  @override
  State<BuddyMain> createState() => _buddyMainState();
}

class _buddyMainState extends State<BuddyMain> {

  bool flag = true;

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserModel?>(context);

    return StreamProvider<List<ChildModel>>.value(
      initialData: [],
      value: DatabaseService(userId: user!.userId).allChildData,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 40.0),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Buddy Page!",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 8.0,
                ),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Register',
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                    
                    TextButton(
                      onPressed: () {
                        if(flag){
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                registerBuddy(
                                    currentuserId: user.userId,),
                          ));
                          flag = false;
                          Text('Register');
                        }else{
                          Text('Registered');
                        }
                      },
                      child: Text('Register'),
                    ),
                  ],
                ),
                
                
              ]),
        ),
      ),
    );
  }
}