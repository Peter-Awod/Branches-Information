import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_observer.dart';
import 'firebase_options.dart';
import 'layouts/home_layout.dart';
import 'modules/login/login_screen.dart';
import 'shared/components/constants.dart';
import 'shared/cubit/app_cubit.dart';
import 'shared/cubit/main_cubit.dart';
import 'shared/cubit/main_states.dart';
import 'shared/network/local/app_cache_helper.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();


  Widget startPoint;

  uId=CacheHelper.getData(key: 'uId');

  if(uId!=null){
    startPoint=const HomeLayoutScreen();
  }
  else{
    startPoint=LoginScreen();
  }

  runApp( MyApp(
    startPoint: startPoint,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startPoint;

  const MyApp({super.key, required this.startPoint});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context){
          return MainCubit();
        }),
        BlocProvider(create: (BuildContext context){
          return AppCubit()..getUserInfo()..getCategories();
        }),
      ],
      child: BlocConsumer<MainCubit,AppMainStates>(
          listener: (context, state){},
          builder: (context, state) {
            return MaterialApp(

              debugShowCheckedModeBanner: false,
              home: startPoint,
            );
          }
      ),
    );
  }
}
