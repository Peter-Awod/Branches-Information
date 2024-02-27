import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/local/app_cache_helper.dart';
import 'main_states.dart';



class MainCubit extends Cubit<AppMainStates> {
  MainCubit() : super(AppInitialState());
  static MainCubit get(context) => BlocProvider.of(context);

bool isDark=false;

void changeAppMode({bool? fromShared})
{
  if(fromShared!=null)
    {
      isDark=fromShared;
      emit(ChangeAppModeState());
    }
  else {
    isDark =!isDark;
    CacheHelper.saveData(key: 'isDark', value: isDark)
        .then((value) {
      emit(ChangeAppModeState());

    });
  }

}


  // void getSearch({required String value}) {
  //   emit(AppGetSearchLoadingState());
  //
  //   ShopDioHelper.postData(
  //       data: {
  //         'text':value,
  //       },
  //       url: SEARCH,
  //     token: token,
  //
  //   ).then((value) {
  //     searchModel=SearchModel.fromJson(value.data);
  //     emit(AppGetSearchSuccessState());
  //   }).catchError((error) {
  //
  //       print(error.toString());
  //     emit(AppGetSearchErrorState(error.toString()));
  //   });
  // }


}