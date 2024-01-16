import 'package:flutter/material.dart';
import 'package:ummicare/models/healthstatusmodel.dart';
import 'package:ummicare/screens/parent_pages/child/health/chronicCondition.dart';
import 'package:ummicare/screens/parent_pages/child/health/healthCodition.dart';
import 'package:ummicare/screens/parent_pages/child/health/physicalCondition.dart';
import 'package:ummicare/services/healthDatabase.dart';

class healthStatus extends StatefulWidget {
  const healthStatus({super.key, required this.healthId,required this.healthStatusId});
  final String healthId;
  final String healthStatusId;

  @override
  State<healthStatus> createState() => _healthStatusState();
}

class _healthStatusState extends State<healthStatus> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HealthStatusModel>(
      stream: HealthDatabaseService().healthStatusData(widget.healthStatusId),
      builder: (context, snapshot){
        final healthData = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: const Text(
              "Health Status",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: const Color(0xffe1eef5),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  StreamBuilder<HealthConditionModel>(
                    stream: HealthDatabaseService().healthConditionData(healthData!.healthConditionId),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        final condition = snapshot.data;
                        return Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                              color: Color(0xff71CBCA),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.medical_information,
                                      size: 30.0,
                                      color: Colors.white,
                                    ),
                                    const Text(
                                      'Health Condition',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                    Flexible(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.arrow_forward,
                                            size: 25.0,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      healthCondition(
                                                          healthConditionId: healthData.healthConditionId,),
                                                ));
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Temperature',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(condition!.currentTemperature),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Heart Rate',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(condition.currentHeartRate),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Illness',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(condition.currentIllness),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }else{
                        return Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                              color: Color(0xff71CBCA),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.medical_information,
                                      size: 30.0,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Health Condition',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
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
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  StreamBuilder<PhysicalConditionModel>(
                    stream: HealthDatabaseService().physicalConditionData(healthData.physicalConditionId),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        final physical = snapshot.data;
                        return Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                              color: Color(0xffF29180),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.personal_injury,
                                      size: 30.0,
                                      color: Colors.white,
                                    ),
                                    const Text(
                                      'Physical Condition',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                    Flexible(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.arrow_forward,
                                            size: 25.0,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      physicalCondition(
                                                          physicalConditionId: healthData.physicalConditionId,),
                                                ));
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Injury',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(physical!.currentInjury),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Details',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(physical.details),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }else{
                        return Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                              color: Color(0xffF29180),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.personal_injury,
                                      size: 30.0,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Physical Condition',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
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
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  StreamBuilder<ChronicConditionModel>(
                    stream: HealthDatabaseService().chronicConditionData(healthData.chronicConditionId),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        final chronic = snapshot.data;
                        return Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                              color: Color(0xff8290F0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.emergency,
                                      size: 30.0,
                                      color: Colors.white,
                                    ),
                                    const Text(
                                      'Chronic Condition',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                    Flexible(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.arrow_forward,
                                            size: 25.0,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      chronicCondition(
                                                          chronicConditionId: healthData.chronicConditionId,),
                                                ));
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Allergies',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(chronic!.childAllergies),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Details',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(chronic.childChronic),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }else{
                        return Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                              color: Color(0xff8290F0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.emergency,
                                      size: 30.0,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Chronix Condition',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
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
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}