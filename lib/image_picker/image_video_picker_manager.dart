import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageVideoPicker {

  ImageVideoPicker._privateConstructor();
  static final ImageVideoPicker instance = ImageVideoPicker._privateConstructor();

  ///Image options
  final List<String> _imageOptions = ["Photo Capture", "Photo From Gallery", "Video Capture", "Video From Gallery","Multiple Image"];

  ///Open Image Picker
  Future<File?> openPickerForImage(BuildContext context, {double? ratioX, double? ratioY}) async {

    String type = await _showBottomSheetForImagePick(context);
    File? croppedFile;

    if(type.isNotEmpty){
      XFile? fileProfile;
      if (_imageOptions.elementAt(0) == type) {
        fileProfile = (await ImagePicker().pickImage(source: ImageSource.camera));
      }
      else if(_imageOptions.elementAt(1) == type) {
        fileProfile = (await ImagePicker().pickImage(source: ImageSource.gallery));
      }

      if (kDebugMode) {
        print("fileProfile: $fileProfile");
      }

      if(fileProfile != null && fileProfile.path != "") {
        CroppedFile? cropImage = (await ImageCropper().cropImage(
          sourcePath: fileProfile.path,
          aspectRatio: CropAspectRatio(ratioX: ratioX ?? 1, ratioY: ratioY ?? 1),
        ));

        if(cropImage != null && cropImage.path != "") {
          croppedFile = File(cropImage.path);
        }
      }
    }
    return croppedFile;
  }

  ///Open Video Picker
  Future<XFile?> openPickerForVideo(BuildContext context) async {
    String type = await _showBottomSheetForVideoPick(context);

    XFile? video;
    if(type.isNotEmpty){
      if(_imageOptions.elementAt(2) == type) {
        video = (await ImagePicker().pickVideo(source: ImageSource.camera));
      }
      else if(_imageOptions.elementAt(3) == type) {
        video = (await ImagePicker().pickVideo(source: ImageSource.gallery));
      }

      if (kDebugMode) {
        print("fileProfile: $video");
      }
    }
    return video;
  }

  ///Open Multiple Image Picker
  Future<List<XFile>?> openPickerForMultipleImages(BuildContext context) async {

    String type = await _showBottomSheetForMultiImagePick(context);
    List<XFile>? images;
    if(type.isNotEmpty){
      if (_imageOptions.elementAt(4) == type) {

        images = await ImagePicker().pickMultiImage();
        // if (selectedImages!.isNotEmpty) {
        //   images?.addAll(selectedImages);
        // }
      }
      if (kDebugMode) {
        print("fileProfile: $images");
      }
    }
    return images;
  }


  //-- image picker
  var imgSelectOption = {"Photo Capture", "Photo From Gallery", "Video Capture", "Video From Gallery","Multiple Image"};

  ///Image option bottom sheet
  _showBottomSheetForImagePick(BuildContext context) async{
    String str = "";
    await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Wrap(
            children: [
              Container(
                color: Colors.transparent,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.only(top: 32,bottom: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // InkWell(
                          //     onTap: (){
                          //       Navigator.pop(context);
                          //       str = imgSelectOption.elementAt(4);
                          //     },
                          //     child:const Text("Multiple Image",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold))
                          // ),
                          // const SizedBox(height: 20),
                          // Container(height: 0.5,color: Colors.grey),
                          // const SizedBox(height: 20),
                          // InkWell(
                          //     onTap: (){
                          //       Navigator.pop(context);
                          //       str = imgSelectOption.elementAt(2);
                          //     },
                          //     child:const Text("Video From Gallery",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold))
                          // ),
                          // const SizedBox(height: 20),
                          // Container(height: 0.5,color: Colors.grey),
                          // const SizedBox(height: 20),
                          // InkWell(
                          //     onTap: (){
                          //       Navigator.pop(context);
                          //       str = imgSelectOption.elementAt(2);
                          //     },
                          //     child:const Text("Video Capture",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold))
                          // ),
                          // const SizedBox(height: 20),
                          // Container(height: 0.5,color: Colors.grey),
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                              str = imgSelectOption.elementAt(1);
                            },
                            child:const Text("Photo From Gallery",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold))
                          ),
                          const SizedBox(height: 20),
                          Container(height: 0.5,color: Colors.grey),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                              str = imgSelectOption.elementAt(0);
                            },
                            child:const Text("Photo Capture",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold))
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: const EdgeInsets.only(left: 70, right: 70,top: 23,bottom: 23),
                          child: const Center(child: Text("Cancel",style:  TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold)))
                      ),
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              ),
            ],
          );
        });
    return str;
  }

  ///Video option bottom sheet
  _showBottomSheetForVideoPick(BuildContext context) async{
    String str = "";
    await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Wrap(
            children: [
              Container(
                color: Colors.transparent,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.only(top: 32,bottom: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: (){
                                Navigator.pop(context);
                                str = imgSelectOption.elementAt(3);
                              },
                              child:const Text("Video From Gallery",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold))
                          ),
                          const SizedBox(height: 20),
                          Container(height: 0.5,color: Colors.grey),
                          const SizedBox(height: 20),
                          InkWell(
                              onTap: (){
                                Navigator.pop(context);
                                str = imgSelectOption.elementAt(2);
                              },
                              child:const Text("Video Capture",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold))
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 19),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: const EdgeInsets.only(left: 70, right: 70,top: 23,bottom: 23),
                          child: const Center(child: Text("Cancel",style:  TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold)))
                      ),
                    ),
                    const SizedBox(height: 20,)
                  ],
                ),
              ),
            ],
          );
        });
    return str;
  }

  /// Multiple Image Bottom Sheet
  _showBottomSheetForMultiImagePick(BuildContext context) async{
    String str = "";
    await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Wrap(
            children: [
              Container(
                color: Colors.transparent,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.only(top: 32,bottom: 32),
                      child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                            str = imgSelectOption.elementAt(4);
                          },
                          child:const Center(child: Text("Multiple Image",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold)))
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: const EdgeInsets.only(left: 70, right: 70,top: 23,bottom: 23),
                          child: const Center(child: Text("Cancel",style:  TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold)))
                      ),
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              ),
            ],
          );
        });
    return str;
  }

}

/* Class usage
File? file = await ImageVideoPicker.instance.openPicker(context);
*/
