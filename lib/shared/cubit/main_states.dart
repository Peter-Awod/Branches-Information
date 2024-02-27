abstract class AppMainStates{}

class AppInitialState extends AppMainStates{}
class BottomNavBarState extends AppMainStates{}


class ChangeAppModeState extends AppMainStates{}


class AppGetSearchLoadingState extends AppMainStates{}
class AppGetSearchSuccessState extends AppMainStates{}
class AppGetSearchErrorState extends AppMainStates{
  final String error;
  AppGetSearchErrorState(this.error);
}


