import 'dart:convert';
import 'dart:typed_data';
import 'package:audio_service/audio_service.dart';
import 'package:on_audio_query_forked/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

// Create an instance of OnAudioQuery for querying audio information
OnAudioQuery onAudioQuery = OnAudioQuery();

// Function to request and check storage permission
Future<void> accessStorage() async =>
    await Permission.storage.status.isGranted.then((granted) async {
      if (granted == false) {
        //request storage permission and open app settings if denied permanently
        PermissionStatus permissionStatus = await Permission.storage.request();
        if (permissionStatus == PermissionStatus.denied) {
          await onAudioQuery.checkAndRequest(retryRequest: true);
        }
        if (permissionStatus == PermissionStatus.permanentlyDenied) {
          await openAppSettings();
        }
      }
    });

// retrieve artwork for a given song ID
Future<Uint8List?> art({required int id}) async {
  return await onAudioQuery.queryArtwork(id, ArtworkType.AUDIO, quality: 100);
}

//Fuction to convert a Uri to an image (Uint8List)
Future<Uint8List?> toImage({required Uri uri}) async {
  return base64.decode(uri.data.toString().split(',').last);
}

// fetch songs and convert to MediaItem format
class FetchSongs {
  //executefetching songs asynchronously
  static Future<List<MediaItem>> execute() async {
    //initialize an empty list to store media items
    List<MediaItem> items = [];

    // ensure storage permission is granted before proceeding
    await accessStorage().then((_) async {
      //query songs using onAudioQuery
      List<SongModel> songs = await onAudioQuery.querySongs();

      //loop through retrieved songs and convert to Mediaitem
      for (SongModel song in songs) {
        if (song.isMusic == true) {
          //Retrieve artwork for the song
          Uint8List? uint8List = await art(id: song.id);
          List<int> bytes = [];
          if (uint8List != null) {
            bytes = uint8List.toList();
          }

          //add converted song to lsit of MediaItems
          items.add(
            MediaItem(
              id: song.uri!,
              title: song.title,
              artist: song.artist,
              duration: Duration(milliseconds: song.duration!),
              artUri: Uri.dataFromBytes(bytes),
            ),
          );
        }
      }
    });
    return items;
  }
}
