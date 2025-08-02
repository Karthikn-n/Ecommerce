import 'package:e_commerce/bloc/nav/nav_state.dart';

abstract class NavigationEvent {}

class NavigationTabChanged extends NavigationEvent {
  final NavigationTab tab;

  NavigationTabChanged(this.tab);
}
