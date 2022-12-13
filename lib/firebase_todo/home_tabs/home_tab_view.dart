import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psspl_bloc_demo/firebase_todo/home_tabs/bloc/home_tab_bloc.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeTabBloc(),
      child: BlocBuilder<HomeTabBloc, HomeTabState>(
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: btmNavBar(state, context),
            body: state.widgetList[state.selectedIndex],
          );
        },
      ),
    );
  }

  btmNavBar(HomeTabState state, BuildContext context) => BottomNavigationBar(
        currentIndex: state.selectedIndex,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notes,
            ),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          context.read<HomeTabBloc>().add(HomeTapEvent(index: index));
        },
      );
}
