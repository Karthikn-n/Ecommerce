import 'package:e_commerce/bloc/nav/nav_event.dart';
import 'package:e_commerce/bloc/nav/nav_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState(NavigationTab.home)) {
    on<NavigationTabChanged>((event, emit) {
      emit(NavigationState(event.tab));
    });
  }

}
