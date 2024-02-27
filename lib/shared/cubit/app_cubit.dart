import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/branche_model/branche_model.dart';
import '../../models/category_model/category_model.dart';
import '../../models/user_model/user_model.dart';
import '../components/constants.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  // changing images index;
  int currentIndex=0;

  void updateIndex(int index){
    currentIndex=index;
    emit(ChangeCurrentIndex());
  }


  // Getting current user information
  UserModel? userModel;

  void getUserInfo() {
    emit(GetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      print('Get User Error State -- -- ${error.toString()}');
      emit(GetUserErrorState(error.toString()));
    });
  }

  // Admin adding new category to  the system
  void addNewCategory({
    required String categoryName,
  }) {
    emit(CreateCategoryLoadingState());

    FirebaseFirestore.instance
        .collection('categories')
        .add({'name': categoryName, 'categoryID': ''}).then((value) {
      String categoryId = value.id;
      value.update({'categoryID': categoryId});

      emit(CreateCategorySuccessState());
    }).catchError((error) {
      print('Category error state ==  ${error.toString()}');
      emit(CreateCategoryErrorState(error.toString()));
    });
  }

  // Getting categories list
  List<CategoryModel> categories = [];

  Future<void> getCategories() async {
    emit(GetCategoriesLoadingState());
    categories = [];
    await FirebaseFirestore.instance
        .collection('categories')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        categories.add(CategoryModel.fromJson(element.data()));
      });
      emit(GetCategoriesSuccessState());
    }).catchError((error) {
      print('Get Category Error State ${error.toString()}');
      emit(GetCategoriesErrorState(error.toString()));
    });
  }

  // select Category
  String? selectedCategory;

  void changeSelectedCategory(newValue) {
    selectedCategory = newValue;
    emit(ChangeDropMenuValueState());
  }

// User adding new branch to  the system
  // images
  List<XFile> selectedImages = [];

  var imagesPicker = ImagePicker();

  Future<void> getImages() async {
    final List<XFile> pickedFiles = await imagesPicker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      selectedImages = pickedFiles;
      emit(PickImagesSuccessState());
    } else {
      print('no images selected');
      emit(PickImagesErrorState());
    }
  }

// upload images urls
  List<String> uploadedImageUrls = [];

  void upload({
    required String branchName,
  }) {
    uploadedImageUrls = [];
    emit(UploadImagesLoadingState());

    selectedImages.forEach((element) {
      File file = File(element.path);

      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('${branchName}/${Uri.file(file.path).pathSegments.last}')
          .putFile(file)
          .then((value) {
        return value.ref.getDownloadURL();
      }).then((imageUrl) {
        uploadedImageUrls.add(imageUrl);

        if (uploadedImageUrls.length == selectedImages.length) {
          emit(UploadImagesSuccessState());
        }
      }).catchError((error) {
        print('Upload Image error state ${error.toString()}');
        emit(UploadImagesErrorState(error.toString()));
      });
    });
  }

  //videos
  XFile? selectedVideos ;
  var videosPicker = ImagePicker();

  Future<void> getVideos() async {
    final pickedFiles = await videosPicker.pickVideo(
        source: ImageSource.gallery);
    if (pickedFiles !=null){
      selectedVideos=XFile(pickedFiles.path);
      emit(PickVideosSuccessState());
    } else {
      print('no video selected');
      emit(PickVideosErrorState());
    }
  }

  List<String> uploadedVideoUrls = [];

  void uploadVideos({
    required String branchName,
  }) {
    uploadedVideoUrls = [];
    emit(UploadVideosLoadingState());
    File file = File(selectedVideos!.path);
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('${branchName}/${Uri.file(file.path).pathSegments.last}')
        .putFile(file)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        uploadedVideoUrls.add(value);
        emit(UploadVideosSuccessState());
      }).catchError((error) {
        print('Upload Video error state ${error.toString()}');
        emit(UploadVideosErrorState(error.toString()));
      });
    }).catchError((error) {
      print('Upload Video error state ${error.toString()}');
      emit(UploadVideosErrorState(error.toString()));
    });
  }


  /////////// create branch
  void addNewbranch({
    required String branchName,
    required String address,
    required String dateTime,
    required String categoryID,
    String? description,
  }) {
    emit(CreateBranchLoadingState());

    BranchModel branchModel = BranchModel(
      userName: userModel!.name,
      uId: userModel!.uId,
      branchID: '',
      branchName: branchName,
      address: address,
      dateTime: dateTime,
      imageUrls: uploadedImageUrls,
      videoUrls: uploadedVideoUrls,
      description: description ?? 'No description added',
    );

    FirebaseFirestore.instance
        .collection('categories')
        .doc(categoryID)
        .collection('branches')
        .add(branchModel.toMap())
        .then((value) {
      String branchId = value.id;
      value.update({'branchID': branchId});
      emit(CreateBranchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreateBranchErrorState(error.toString()));
    });
  }

  // get branches

  List<BranchModel> branches = [];

  Future<void> getBranches({
    required String categoryId,
  }) async {
    emit(GetBranchesLoadingState());
    branches = [];

    await FirebaseFirestore.instance
        .collection('categories')
        .doc(categoryId)
        .collection('branches')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        branches.add(BranchModel.fromJson(element.data()));
      });
      emit(GetBranchesSuccessState());
    }).catchError((error) {
      print('Get Branches error state ${error.toString()}');
      emit(GetBranchesErrorState(error.toString()));
    });
  }
}
