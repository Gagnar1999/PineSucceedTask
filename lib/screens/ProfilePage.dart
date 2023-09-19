import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/provider/ProfileProvider.dart';
import 'package:test_project/extension/Extension.dart';

import '../dialog/DialogUpdateDetails.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    provider.getLoggedInUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        actions: [
          InkWell(onTap:(){
            showDialog(context: context, builder: (builder)=> UpdateDialog());
          },
              child: Icon(Icons.edit_outlined, color: Colors.white,)),
          SizedBox(width: 22,),
        ],
        title: Text(
          "Profile",
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Consumer<ProfileProvider>(
        builder:(ctx, value, child)=> Column(
          children: [
            SizedBox(height: 30,),
            Card(
              color: Colors.indigo,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(value.user?.photoURL ??
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtvCOreygxelB5CQsDGrnNi8Hw0P2FaBiV86idpmdqMgA2uqgRczjAGRJIXPRbOMtTj-I&usqp=CAU"),
                    ),
                    SizedBox(width: 30,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(value.user?.displayName?.capitalize()??"", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                          Text(value.user?.email??"", style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
                          Text("E-mail Verified: ${value.user?.emailVerified??false}", style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
