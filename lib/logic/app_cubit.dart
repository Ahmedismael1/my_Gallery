// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery/core/constant/variable.dart';
import 'package:my_gallery/core/end_point/end_point.dart';
import 'package:my_gallery/data/models/get_image_model.dart';
import 'package:my_gallery/data/remote/dio/dio_helper.dart';
import 'package:my_gallery/logic/app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  File? imagee;
  var rng = Random();

  File? image;
  var picker = ImagePicker();

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      image = File(pickedFile.path);
      print(image);
      print(Uri.file(image!.path).pathSegments.last);
      uploadGalleryImage(pickedImages: image);
      emit(PickImageSuccessState());
    } else {
      print('No image selected.');
      emit(PickImageErrorState());
    }
  }
  //
  // Future PickImage()async{
  //   final image=await ImagePicker().pickImage(source: ImageSource.gallery);
  //   final imageTemporary=File(image!.path);
  //
  //   File file = new File('$imageTemporary'+ (rng.nextInt(100)).toString() +'.png');
  //
  //  imagee== MultipartFile.fromFileSync(image.path);
  //   uploadGalleryImage(pickedImages: file);
  //
  //   emit(PickImageSuccessState());
  //   print(file);
  //   if (image==null) {
  //     emit(PickImageErrorState());
  //
  //     return;
  //   }
  //
  // }
//   Future<File> urlToFile(String imageUrl) async {
// // generate random number.
//     var rng = Random();
// // get temporary directory of device.
//     Directory tempDir = await getTemporaryDirectory();
// // get temporary path from temporary directory.
//     String tempPath = tempDir.path;
// // create a new file in temporary path with random file name.
//     File file = new File('$tempPath'+ (rng.nextInt(100)).toString() +'.png');
// // call http.get method and pass imageUrl into it to get response.
//     http.Response response = await http.get(imageUrl);
// // write bodyBytes received in response to file.
//     await file.writeAsBytes(response.bodyBytes);
// // now return the file which is created with random name in
// // temporary directory and image bytes from response is written to // that file.
//     return file;
//   }
  void uploadGalleryImage({File? pickedImages})
  {
    print("object");
    DioHelper.postData(url: UPLOADIMAGE,
        token: accessToken,
        data:
    {
      'img' : pickedImages
    })
        .then((value){
      emit(UploadGalleryImageSuccessState());
    })
        .catchError((error){
      if(error is DioError) {
        print(error.response);
      }
      emit(UploadGalleryImageErrorState());
    });
  }
  void uploadImage(){
    emit(UploadLoadingState());

    DioHelper.postData(token: 'Bearer $accessToken',
        url: UPLOADIMAGE,
        data: {
          'img':imagee
        }
    ).then((value) {
      print('//////////////////////////');
      print(value.data);
      emit(UploadSuccessState());
    })
        .catchError((error){
      print("Error in SignIn is: ${error.toString()}");
      emit(UploadErrorState());
    });
  }

  GetImagesModel? getImagesModel;
  void getImages(){
    emit(GetImageLoadingState());

    DioHelper.getData(
        url: 'my-gallery'
        ,token: accessToken)
        .then((value) {
      getImagesModel=GetImagesModel.fromJson(value.data);
      print(value.data);
      print(getImagesModel!.data!.images![0]);
      emit(GetImageSuccessState());
    })
        .catchError((error){
      print('11111111111111111'+error.toString());
      emit(GetImageErrorState());

    });

  }
}