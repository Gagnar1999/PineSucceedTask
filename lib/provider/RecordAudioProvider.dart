import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';

class RecordAudioProvider with ChangeNotifier{
  bool isPermissionAllowed = false;
  int duration = 0;
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _isRecordingStarted = false;
  Timer? _timer = null;
  List<File> files = [];
  bool _isPlaying = false;
  int playingPos = -1;


  void startRecording() async {

    if (isPermissionAllowed) {
      Directory appFolder = await getApplicationDocumentsDirectory();
      final filepath = appFolder.path +
          '/' +
          DateTime.now().millisecondsSinceEpoch.toString() +
          '.aac';
      print(filepath);
      if(!_isRecordingStarted){

        await _mRecorder!.openRecorder();
        await _mRecorder!
            .startRecorder(
            toFile: filepath,
            codec: Codec.aacMP4
        );
        _isRecordingStarted = true;
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          duration = timer.tick;
          if(duration == 15){
            stopRecording();
          }
          notifyListeners();
        });
      }


    } else {
      print('Permissions not granted');
    }
  }

  void play(int pos) async{
    if(_isPlaying){
      await _mPlayer?.stopPlayer();
    }
    if(!_isPlaying){
      await _mPlayer?.openPlayer();
      await _mPlayer?.startPlayer(fromURI: files[pos].path);
      _timer?.cancel();
      _timer = Timer.periodic(Duration(seconds: 1), (timer) async{
        var playerState = await _mPlayer?.getPlayerState();
        if(playerState!= null && playerState == PlayerState.isStopped){
          playingPos = -1;
          _timer?.cancel();
          _timer = null;
          notifyListeners();
        }
      }

      );
      playingPos = pos;
    }
    else if(playingPos == pos){
      await _mPlayer?.stopPlayer();
      pos = -1;
    }

    notifyListeners();
  }

  void stopRecording() async {

    if (_isRecordingStarted) {
      var url = await _mRecorder!
          .stopRecorder(
      );
      if(url!= null){
        files.add(File(url));
      }
      _timer?.cancel();
      _timer = null;
      duration = 0;
      _isRecordingStarted = false;
      notifyListeners();
    } else {
      print('Permissions not granted');
    }
  }

  @override
  void dispose() {
    _mPlayer?.closePlayer();
    _mRecorder?.closeRecorder();
    _mRecorder = null;
    _mPlayer = null;
    super.dispose();
  }

}