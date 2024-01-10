import 'package:flutter/material.dart';
import 'package:ummicare/models/buddyModel.dart';
import 'package:ummicare/screens/parent_pages/buddy/buddylist/buddyProfileList.dart';
import 'package:ummicare/services/buddyDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class buddySearchProfile extends StatefulWidget {
  const buddySearchProfile({super.key, required this.buddyProfileId});
  final String buddyProfileId;

  @override
  State<buddySearchProfile> createState() => _buddySearchProfileState();
}

class _buddySearchProfileState extends State<buddySearchProfile> {
  final _formKey = GlobalKey<FormState>();

  String searchName = '';
  List<buddyProfileModel> searchedProfile = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<buddyProfileModel>(
      stream: buddyDatabase().buddyProfileData(widget.buddyProfileId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          buddyProfileModel? profile = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Search Profile",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              elevation: 3,
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 20.0),
                  child: Column(
                    children: [
                      StreamBuilder<List<buddyProfileModel>>(
                          stream: buddyDatabase().allBuddyProfileData,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<buddyProfileModel>? profilesList =
                                  snapshot.data;
                              return Form(
                                key: _formKey,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: TextFormField(
                                        initialValue: searchName,
                                        decoration: textInputDecoration
                                            .copyWith(hintText: 'Profile Name'),
                                        validator: (value) => value == ''
                                            ? 'Please enter profile name'
                                            : null,
                                        onChanged: ((value) => setState(() {
                                              searchName = value;
                                            })),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.search,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                      style: IconButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff8290F0)),
                                      onPressed: () async {
                                        searchedProfile.clear();
                                        for (int i = 0;
                                            i < profilesList!.length;
                                            i++) {
                                          if (profilesList[i]
                                              .buddyProfileUsername
                                              .toLowerCase()
                                              .contains(
                                                  searchName.toLowerCase())) {
                                            setState(() {
                                              if (profilesList[i]
                                                      .buddyProfileId !=
                                                  profile!.buddyProfileId) {
                                                searchedProfile
                                                    .add(profilesList[i]);
                                              }
                                            });
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                      const SizedBox(height: 30),
                      buddyProfileList(
                        profileList: searchedProfile,
                        userId: profile!.buddyProfileId,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
