part of 'home_tab_bloc.dart';

@immutable
abstract class HomeTabState {
  final List<Widget> widgetList = [
    const VideoView(),
    const HomeView(),
    ProfileView(),
  ];
  final int selectedIndex;

  HomeTabState(this.selectedIndex);
}

class HomeTabInitial extends HomeTabState {
  final int index;

  HomeTabInitial(this.index) : super(index);
}
