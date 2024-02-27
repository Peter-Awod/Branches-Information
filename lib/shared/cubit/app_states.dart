abstract class AppStates {}

class AppInitialState extends AppStates {}

class ChangeCurrentIndex extends AppStates{}


// User States
class GetUserLoadingState extends AppStates {}

class GetUserSuccessState extends AppStates {}

class GetUserErrorState extends AppStates {
  final String error;

  GetUserErrorState(this.error);
}

// Category States

class CreateCategoryLoadingState extends AppStates {}

class CreateCategorySuccessState extends AppStates {}

class CreateCategoryErrorState extends AppStates {
  final String error;

  CreateCategoryErrorState(this.error);
}

class ChangeDropMenuValueState extends AppStates {}

class GetCategoriesLoadingState extends AppStates {}

class GetCategoriesSuccessState extends AppStates {}

class GetCategoriesErrorState extends AppStates {
  final String error;

  GetCategoriesErrorState(this.error);
}

// Branch States

class CreateBranchLoadingState extends AppStates {}

class CreateBranchSuccessState extends AppStates {}

class CreateBranchErrorState extends AppStates {
  final String error;

  CreateBranchErrorState(this.error);
}

// images
class PickImagesSuccessState extends AppStates {}

class PickImagesErrorState extends AppStates {}

class UploadImagesLoadingState extends AppStates {}

class UploadImagesSuccessState extends AppStates {}

class UploadImagesErrorState extends AppStates {
  final String error;

  UploadImagesErrorState(this.error);
}

// videos
class PickVideosSuccessState extends AppStates {}

class PickVideosErrorState extends AppStates {}

class UploadVideosLoadingState extends AppStates {}

class UploadVideosSuccessState extends AppStates {}

class UploadVideosErrorState extends AppStates {
  final String error;

  UploadVideosErrorState(this.error);
}

// get

class GetBranchesLoadingState extends AppStates {}

class GetBranchesSuccessState extends AppStates {}

class GetBranchesErrorState extends AppStates {
  final String error;

  GetBranchesErrorState(this.error);
}
