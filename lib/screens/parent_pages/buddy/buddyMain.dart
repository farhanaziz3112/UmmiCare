import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/buddymodel.dart';
import 'package:ummicare/screens/parent_pages/buddy/registerBuddy.dart';
import 'package:ummicare/services/buddyDatabase.dart';

import '../../../models/usermodel.dart';

class BuddyMain extends StatefulWidget {
  const BuddyMain({super.key});

  @override
  State<BuddyMain> createState() => _buddyMainState();
}

class _buddyMainState extends State<BuddyMain> {
  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserModel?>(context);

    return StreamBuilder<BuddyModel>(
      stream: BuddyDatabaseService(userId: user!.userId).buddyData,
      builder: (context, snapshot) {
        BuddyModel? buddy = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Buddy Page',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    //backgroundImage: NetworkImage(buddy.imageURL),
                    radius: 50.0,
                    backgroundColor: Colors.grey,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  StreamBuilder<BuddyModel>(
                    stream: BuddyDatabaseService(userId: user.userId).buddyData,
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Color(0xff8290F0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.health_and_safety,
                                      size: 30.0,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      ' Buddy',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    child: SpinKitPulse(
                                      color: Colors.black,
                                      size: 20.0,
                                    )
                                  )

                              ],
                            ),
                          ),
                        );
                      }else {
                      List<BuddyModel> buddyModelData = [];
                      if (snapshot.hasData) {
                        buddyModelData = snapshot.data! as List<BuddyModel>;
                      }
                      if (buddyModelData.isEmpty) {
                        return Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Color(0xff8290F0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Container(
                            padding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.health_and_safety,
                                      size: 30.0,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      ' Buddy',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Text(
                                        "*Your child currently does not have Buddy Module. Please register by clicking the button below.",
                                        style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 13.0),
                                      ),
                                      ElevatedButton(
                                        child: Text(
                                          'Register Buddy Module',
                                          style: TextStyle(
                                              color: Colors.black),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white),
                                        onPressed: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      registerBuddy(
                                                          currentuserId: user.userId)));
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }else {
                        return Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Color(0xff8290F0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Container(
                            padding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.health_and_safety,
                                      size: 30.0,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      ' Buddy',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white),
                                    ),
                                    Flexible(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          icon: Transform.scale(
                                            scaleX: -1,
                                            child: Icon(
                                              Icons.arrow_back,
                                              size: 25.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BuddyMain(),
                                                ));
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            ),
                          ),
                        );

                      }
                      }
                    }
                  ),
                ]
              )
            )
          )
        );
      }
    );
  }
}