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


  File? image;
  var picker = ImagePicker();

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
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
  void uploadGalleryImage({File? pickedImages}) {
    print("object");
    DioHelper.postData(
        url: UPLOADIMAGE,
        token: accessToken,
        data: FormData.fromMap(
            {"img": MultipartFile.fromFileSync(pickedImages!.path)}))
        .then((value) {
      getImages();
      emit(UploadGalleryImageSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        print(error.response);
      }
      emit(UploadGalleryImageErrorState());
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