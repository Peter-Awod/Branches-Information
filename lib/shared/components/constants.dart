import 'package:flutter/material.dart';
import '../../modules/login/login_screen.dart';
import '../network/local/app_cache_helper.dart';
import 'components.dart';


const defaultColor = Colors.blue;


// logout button with uId
void logOut({required BuildContext context})
{

      CacheHelper.removeToken(key: 'uId').then((value){
        if(value!){
          uId='';
          pushAndRemoveNavigateTo(context, LoginScreen());
        }
      });
}
// logout button with token
void signOut({required BuildContext context})
{

      CacheHelper.removeToken(key: 'token').then((value){
        if(value!){
          pushAndRemoveNavigateTo(context, LoginScreen());
        }
      });
}


// String? token='';

String? uId='';