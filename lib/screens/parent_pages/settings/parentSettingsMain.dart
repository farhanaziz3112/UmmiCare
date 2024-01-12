import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/screens/parent_pages/settings/parentContactUs.dart';
import 'package:ummicare/screens/parent_pages/settings/parentEditProfile.dart';
import 'package:ummicare/screens/parent_pages/settings/parentPrivacyPolicy.dart';
import 'package:ummicare/screens/parent_pages/settings/parentTermsOfUse.dart';
import 'package:ummicare/screens/parent_pages/settings/parentVersion.dart';
import 'package:ummicare/services/auth.dart';

class parentSettingsMain extends StatefulWidget {
  const parentSettingsMain({super.key});

  @override
  State<parentSettingsMain> createState() => _parentSettingsMainState();
}

class _parentSettingsMainState extends State<parentSettingsMain> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    parentModel? parent = Provider.of<parentModel?>(context);
    final parentId = parent!.parentId;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          OutlinedButton.icon(
            icon: const Icon(
              Icons.person_3,
              size: 24.0,
              color: Colors.black,
            ),
            style: OutlinedButton.styleFrom(
              primary: const Color.fromARGB(255, 255, 255, 255),
              minimumSize: const Size.fromHeight(60),
              alignment: Alignment.centerLeft,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          parentEditProfile(parentId: parentId)));
            },
            label: const Text(
              'Edit Profile',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          OutlinedButton.icon(
            icon: const Icon(
              Icons.system_update_alt,
              size: 24.0,
              color: Colors.black,
            ),
            style: OutlinedButton.styleFrom(
              primary: const Color.fromARGB(255, 255, 255, 255),
              minimumSize: const Size.fromHeight(60),
              alignment: Alignment.centerLeft,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          parentVersion()));
            },
            label: const Text(
              'Version',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          OutlinedButton.icon(
            icon: const Icon(
              Icons.article,
              size: 24.0,
              color: Colors.black,
            ),
            style: OutlinedButton.styleFrom(
              primary: const Color.fromARGB(255, 255, 255, 255),
              minimumSize: const Size.fromHeight(60),
              alignment: Alignment.centerLeft,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          parentPrivacyPolicy()));
            },
            label: const Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          OutlinedButton.icon(
            icon: const Icon(
              Icons.pan_tool,
              size: 24.0,
              color: Colors.black,
            ),
            style: OutlinedButton.styleFrom(
              primary: const Color.fromARGB(255, 255, 255, 255),
              minimumSize: const Size.fromHeight(60),
              alignment: Alignment.centerLeft,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          parentTermsOfUse()));
            },
            label: const Text(
              'Terms of Use',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          OutlinedButton.icon(
            icon: const Icon(
              Icons.phone,
              size: 24.0,
              color: Colors.black,
            ),
            style: OutlinedButton.styleFrom(
              primary: const Color.fromARGB(255, 255, 255, 255),
              minimumSize: const Size.fromHeight(60),
              alignment: Alignment.centerLeft,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          parentContactUs()));
            },
            label: const Text(
              'Contact Us',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          OutlinedButton.icon(
            icon: const Icon(
              Icons.logout,
              size: 24.0,
              color: Colors.black,
            ),
            style: OutlinedButton.styleFrom(
              primary: const Color.fromARGB(255, 255, 255, 255),
              minimumSize: const Size.fromHeight(60),
              alignment: Alignment.centerLeft,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: () async {
              await _auth.signOut();
            },
            label: const Text(
              'Logout',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}