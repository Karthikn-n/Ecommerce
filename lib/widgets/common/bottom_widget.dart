import 'package:e_commerce/bloc/nav/nav_bloc.dart';
import 'package:e_commerce/bloc/nav/nav_event.dart';
import 'package:e_commerce/bloc/nav/nav_state.dart';
import 'package:e_commerce/ui/cart_screen.dart';
import 'package:e_commerce/ui/home_screen.dart';
import 'package:e_commerce/ui/profile_screen.dart';
import 'package:e_commerce/ui/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomWidget extends StatelessWidget {
  BottomWidget({super.key});

  final List<Widget> screens = [
    HomeScreen(),
    CartScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        int currentIndex = NavigationTab.values.indexOf(state.tab);
        return Scaffold(
          body: screens[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: currentIndex,
            onTap: (index) {
              final selectedTab = NavigationTab.values[index];
              context.read<NavigationBloc>().add(NavigationTabChanged(selectedTab));
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(state.tab == NavigationTab.home ? Icons.home : Icons.home_outlined, color: Colors.black,), 
                label: ''
              ),
              BottomNavigationBarItem(
                icon: Icon(state.tab == NavigationTab.cart ? Icons.shopping_cart : Icons.shopping_cart_outlined, color: Colors.black,), 
                label: ''
              ),
              BottomNavigationBarItem(
                icon: Icon(state.tab == NavigationTab.search ? Icons.search : Icons.search_outlined, color: Colors.black,), 
                label: ''
              ),
              BottomNavigationBarItem(
                icon: Icon( state.tab == NavigationTab.profile ? Icons.person : Icons.person_outline, color: Colors.black,), 
                label: ''
              ),
            ],
          ),
        );
      },
    );
  }
}
