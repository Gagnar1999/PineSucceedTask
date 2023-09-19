import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/screens/ProfilePage.dart';
import 'dart:math' as math;
import '../provider/HomePageProvider.dart';
import 'RecordAudioScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    final provider = Provider.of<HomePageProvider>(context, listen: false);
    provider.getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomePageProvider>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Posts",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22),
          ),
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(ctx)=> ProfilePage() ));
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(provider.user?.photoURL ??
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtvCOreygxelB5CQsDGrnNi8Hw0P2FaBiV86idpmdqMgA2uqgRczjAGRJIXPRbOMtTj-I&usqp=CAU"),
              ),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: Column(
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=> RecordAudioScreen()));
              },
              child: Center(
                child: Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.indigoAccent
                  ),
                  child: Icon(Icons.mic, color: Colors.white, size: 35,),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Consumer<HomePageProvider>(
                builder: (ctx, child, value) => ListView.builder(
                    itemBuilder: (ctx, pos) => Card(
                          color: Color((math.Random().nextDouble() * 0xA0DFAA)
                                  .toInt())
                              .withOpacity(1.0),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Column(
                              children: [
                                Text(
                                  provider.posts[pos].title ?? "",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                Text(
                                  provider.posts[pos].body ?? "",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                )
                              ],
                            ),
                          ),
                        ),
                    itemCount: provider.posts.length),
              ),
            )
          ],
        ));
  }
}
