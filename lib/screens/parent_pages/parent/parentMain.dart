// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/services/auth.dart';
import 'package:ummicare/services/parentDatabase.dart';
import 'package:ummicare/screens/parent_pages/child/childlist/childlist.dart';

class parentMain extends StatefulWidget {
  const parentMain({super.key});

  @override
  State<parentMain> createState() => _parentMainState();
}

class _parentMainState extends State<parentMain> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    parentModel? parent = Provider.of<parentModel?>(context);
    if (parent == null) {
      return Container();
    } else {
      return StreamProvider<List<childModel>>.value(
        initialData: [],
        value: parentDatabase(parentId: parent!.parentId).allChildData,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40.0),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Welcome, ${parent.parentFullName}!",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Last login: ${_auth.getUserLastSignedIn()}',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Text('Recent Activites',
                      style: TextStyle(color: Colors.black, fontSize: 20.0)),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // ignore: sized_box_for_whitespace
                  Container(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          width: 130,
                          margin: const EdgeInsets.all(5.0),
                          decoration: const BoxDecoration(
                              color: Color(0xff71CBCA),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: const Center(
                              child: Text(
                            'Item 1',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                        ),
                        Container(
                          width: 130,
                          margin: const EdgeInsets.all(5.0),
                          decoration: const BoxDecoration(
                              color: Color(0xff8290F0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: const Center(
                              child: Text(
                            'Item 2',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                        ),
                        Container(
                          width: 130,
                          margin: const EdgeInsets.all(5.0),
                          decoration: const BoxDecoration(
                              color: Color(0xffF29180),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: const Center(
                              child: Text(
                            'Item 3',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                        ),
                        Container(
                          width: 130,
                          margin: const EdgeInsets.all(5.0),
                          decoration: const BoxDecoration(
                              color: Color(0xff71CBCA),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: const Center(
                              child: Text(
                            'Item 4',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Row(
                    children: <Widget>[
                      Text(
                        'Your Child',
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                    ],
                  ),
                  const childList(),
                ]),
          ),
        ),
      );
    }
  }
}
