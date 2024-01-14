import 'package:flutter/material.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/notificationModel.dart';
import 'package:ummicare/services/childDatabase.dart';
import 'package:ummicare/services/notificationDatabase.dart';
import 'package:ummicare/shared/constant.dart';
import 'package:ummicare/shared/function.dart';

class notification extends StatefulWidget {
  const notification({super.key, required this.parentId});
  final String parentId;

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<notificationModel>>(
      stream: notificationDatabase()
          .allnotificationDataWithParentId(widget.parentId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<notificationModel>? notifs = snapshot.data;
          notifs!.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Notification",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.black),
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              elevation: 3,
            ),
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: notifs.isEmpty
                  ? Center(child: noData('Oops! Nothing here...'))
                  : SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 20.0),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  for (int i = 0; i < notifs.length; i++) {
                                    notificationDatabase()
                                        .updateNotificationData(
                                            notifs[i].notificationId,
                                            notifs[i].parentId,
                                            notifs[i].childId,
                                            notifs[i].type,
                                            notifs[i].title,
                                            notifs[i].description,
                                            'seen',
                                            notifs[i].createdAt);
                                  }
                                },
                                child: const Text(
                                  'Mark All As Seen',
                                  style: TextStyle(color: Color(0xff8290F0)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: notifs.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 20, 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Text(
                                              notifs[index].title,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18),
                                            ),
                                            Expanded(child: Container()),
                                            notifs[index].status == 'notified'
                                                ? const CircleAvatar(
                                                    backgroundColor:
                                                        Color(0xff8290F0),
                                                    radius: 5,
                                                  )
                                                : Container(
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text(
                                                          'Seen',
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color: Colors
                                                                  .grey[800]),
                                                        ),
                                                        Icon(
                                                          Icons.check,
                                                          size: 15,
                                                        )
                                                      ],
                                                    ),
                                                  )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0, vertical: 5),
                                          child: Container(
                                            height: 1.0,
                                            width: double.infinity,
                                            color: Colors.grey[300],
                                          ),
                                        ),
                                        notifs[index].childId == ''
                                            ? Container()
                                            : StreamBuilder<childModel>(
                                                stream: childDatabase(
                                                        childId: notifs[index]
                                                            .childId)
                                                    .childData,
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                      '${snapshot.data!.childName}',
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    );
                                                  } else {
                                                    return Container();
                                                  }
                                                }),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(notifs[index].description),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            convertTimeToDateString(
                                                notifs[index].createdAt),
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey[700]),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Notification",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.black),
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              elevation: 3,
            ),
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Center(child: noData('Oops! Nothing here...')),
            ),
          );
        }
      },
    );
  }
}
