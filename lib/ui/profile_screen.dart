import 'package:e_commerce/bloc/nav/nav_bloc.dart';
import 'package:e_commerce/bloc/nav/nav_event.dart';
import 'package:e_commerce/bloc/nav/nav_state.dart';
import 'package:e_commerce/bloc/profile/profile_bloc.dart';
import 'package:e_commerce/bloc/profile/profile_state.dart';
import 'package:e_commerce/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: Text("Profile")),
      body: SingleChildScrollView(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if(state.signout) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Signout successfully")),
              );
              context.read<NavigationBloc>().add(NavigationTabChanged(NavigationTab.home));
              Navigator.pushNamedAndRemoveUntil(context, AppRouter.login, (route) => false,);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Center(
                child: state.error != null
                ? Text(state.error ?? "Something went wrong")
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 80),
                    SizedBox(
                      height: 150,
                      child: Image.asset(
                        "assets/user.png",
                        color: Colors.grey.shade400,
                      ),
                    ),
                    SizedBox(height: 40,),
                    Text(state.user!.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),),
                    Text(state.user!.email, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                    SizedBox(height: 80,),
                    FilledButton(
                      onPressed: (){
                        context.read<ProfileCubit>().signout();
                      }, 
                      child: Text("Signout")
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
