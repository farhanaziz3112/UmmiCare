import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/screens/parent_pages/buddy/registerBuddy.dart';
import 'package:ummicare/services/parentDatabase.dart';

class BuddyMain extends StatefulWidget {
  const BuddyMain({super.key});

  @override
  State<BuddyMain> createState() => _BuddyMainState();
}

class _BuddyMainState extends State<BuddyMain> {
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    parentModel? user = Provider.of<parentModel?>(context);

    return StreamProvider<List<parentModel>>.value(
      initialData: [],
      value: parentDatabase(parentId: user!.parentId).allParentData,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Buddy Page!",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 50,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Text(
                  "You currently does not have Buddy Page. Please register by clicking the button below.",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff8290F0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => registerBuddy(
                          parentId: user.parentId,
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
  }
}