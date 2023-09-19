import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:test_project/provider/RecordAudioProvider.dart';

class RecordAudioScreen extends StatefulWidget {
  const RecordAudioScreen({Key? key}) : super(key: key);

  @override
  State<RecordAudioScreen> createState() => _RecordAudioScreenState();
}

class _RecordAudioScreenState extends State<RecordAudioScreen> {
  late final provider =
      Provider.of<RecordAudioProvider>(context, listen: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      var status = await Permission.microphone.status;
      if (status == PermissionStatus.granted) {
        provider.isPermissionAllowed = true;
      } else {
        Permission.microphone.request().then((value) {
          if (value == PermissionStatus.granted) {
            provider.isPermissionAllowed = true;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Please Allow Microphone Permission")));
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          "Record Audio",
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Text(
            "You can start your recording by pressing start recording button",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22),
            textAlign: TextAlign.center,
          ),
          Selector<RecordAudioProvider, int>(
            selector: (_, provider) => provider.duration,
            builder: (context, value, child) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: value / 15,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "$value Seconds",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: FilledButton(
                onPressed: () {
                  provider.startRecording();
                },
                child: Text("Start Recording"),
              )),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: FilledButton(
                onPressed: () {
                  provider.stopRecording();
                },
                child: Text("Stop Recording"),
              )),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          SizedBox(height: 20,),
          Expanded(
            child: Consumer<RecordAudioProvider>(
                builder: (ctx, value, child) => ListView.builder(
                  itemBuilder: (ctx, pos)=> Card(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    color: Colors.indigo,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Expanded(child: Text(value.files[pos].path,style: const TextStyle(color: Colors.white),)),
                          SizedBox(width: 20,),
                          InkWell(
                              onTap: (){
                                provider.play(pos);
                              },
                              child: value.playingPos == pos?Icon(Icons.pause, color: Colors.white,):Icon(Icons.play_arrow, color: Colors.white,)
                          )
                        ],
                      ),
                    ),
                  ),
                  itemCount: value.files.length,
                )
            ),
          )
        ],
      ),
    );
  }
}
