import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_demo/image_picker/image_video_picker_manager.dart';
import 'package:image_picker_demo/image_picker/multi_image_picked_screen.dart';
import 'package:image_picker_demo/image_picker/video_player_screen.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  State<StartingScreen> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<StartingScreen> {
  /// Need to Initialize First Image Picker Object

  File? pickedImage;
  XFile? pickedVideo;
  List<XFile>? pickedImages;

  /// Pick an image
  //     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  /// Capture a photo
  //     final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
  /// Pick a video
  //     final XFile? image = await _picker.pickVideo(source: ImageSource.gallery);
  /// Capture a video
  //     final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
  /// Pick multiple images
  //     final List<XFile>? images = await _picker.pickMultiImage();

  /// Need To Add this Lines for Give Support in IOS Device
  /* put this lines inside ios/Runner/Info.plist

  <key>NSCameraUsageDescription</key>
	<string>Used to demonstrate image picker plugin</string>
	<key>NSMicrophoneUsageDescription</key>
	<string>Used to capture audio for image picker plugin</string>
	<key>NSPhotoLibraryUsageDescription</key>
	<string>Used to demonstrate image picker plugin</string>
  * */
  ///------------------------------------------//////////
  ///
  /// image Configuration for Android and For Ios No Configuration Required
  /*
   <activity
           android:name="com.yalantis.ucrop.UCropActivity"
           android:screenOrientation="portrait"
           android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>
   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Image Picker For Single Image",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Visibility(
              visible: pickedImage != null,
              child: Image.file(
                File(pickedImage?.path ?? ""),
                width: 200,
                height: 200,
              )),
          const SizedBox(
            height: 100,
          ),
          Center(
            child: TextButton(
              onPressed: () async {
                File? file =
                    await ImageVideoPicker.instance.openPickerForImage(context);
                setState(() {
                  pickedImage = file;
                });
              },
              child: const Text("Single Image Selection"),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () async {
                XFile? file =
                    await ImageVideoPicker.instance.openPickerForVideo(context);
                setState(() {
                  pickedVideo = file;
                });
                if (pickedVideo != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoPlayerScreen(
                                pickedVideo: pickedVideo,
                              )));
                }
              },
              child: const Text("Single Video Selection"),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () async {
                List<XFile>? file = await ImageVideoPicker.instance
                    .openPickerForMultipleImages(context);
                setState(() {
                  pickedImages = file;
                });
                if (pickedImages != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MultiImagePickedScreen(
                                imageFiles: pickedImages,
                              )));
                }
              },
              child: const Text("MultiImage Picker"),
            ),
          ),
        ],
      ),
    );
  }
}
