import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/models/healthmodel.dart';
import 'package:ummicare/screens/parent_pages/child/health/healthAppointment.dart';
import 'package:ummicare/screens/parent_pages/child/health/healthStatus.dart';
import 'package:ummicare/screens/parent_pages/child/health/editPhysical.dart';
import 'package:ummicare/screens/parent_pages/child/health/addNewHealthStatusData.dart';

import 'package:ummicare/services/healthDatabase.dart';

class healthMain extends StatefulWidget {
  const healthMain({super.key, required this.childId, required this.healthId, required this.healthStatusId});
  final String childId;
  final String healthId;
  final String healthStatusId;


  @override
  State<healthMain> createState() => _healthMainState();
}

class _healthMainState extends State<healthMain> {

  bool flag = true;

  void _editPhysical() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: EditPhysical(childId: widget.childId, healthId: widget.healthId, healthStatusId: widget.healthStatusId,),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<HealthModel>>(
      stream: HealthDatabaseService(childId: widget.childId).healthData,
      builder: (context, snapshot) {
        final healthData = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: const Text(
              "Health",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: const Color(0xffe1eef5),
            actions: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.person),
                label: Text('EditHealth'),
                onPressed: () => _editPhysical(),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("graph"),
                          SizedBox(
                            height: 5.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 150,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Color(0xffF29180),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(5, 20, 0, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.height,
                                      size: 30.0,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      ' Height',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                    '${healthData?[0].currentHeight}'
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Color(0xff8290F0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(5, 20, 0, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.monitor_weight,
                                      size: 30.0,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      ' Weight',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                    '${healthData?[0].currentWeight}'
                                ,)
                              ],
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                   Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Color(0xff71CBCA),
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
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
                                ' Health Status',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                              Flexible(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      size: 25.0,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      if(flag){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                addNewHealthStatusData(
                                                    healthStatusId: widget.healthStatusId,),
                                          ));
                                        flag = false;
                                      }else{
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                healthStatus(
                                                    childId: widget.childId, healthId: widget.healthId,healthStatusId: widget.healthStatusId
                                                    ,),
                                          ));
                                      }
                                      
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
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Color(0xffF29180),
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.vaccines,
                                size: 30.0,
                                color: Colors.white,
                              ),
                              Text(
                                ' Health Appointment',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                              Flexible(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      size: 25.0,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                healthAppointment(
                                                    childId: widget.childId),
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
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}