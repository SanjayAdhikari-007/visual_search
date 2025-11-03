import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visual_search/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:visual_search/core/theme/app_pallete.dart';
import 'package:visual_search/features/auth/presentation/pages/login_page.dart';
import 'package:visual_search/features/classifier/presentation/cubit/classifier_cubit.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';

class ProfilePage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      );
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = (context.read<AppUserCubit>().state as AppUserLoggedIn).user;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.pushAndRemoveUntil(
            context,
            LoginPage.route(),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            children: [
              Row(
                spacing: 20,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.black,
                    child: SvgPicture.asset(
                      "assets/icons/Profile.svg",
                      color: AppPallete.buttonBlueColor,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name),
                      Text(user.email),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            actions: [
                              TextButton(
                                child: Text("Cancel",
                                    style: TextStyle(
                                      color: AppPallete.buttonBlueColor,
                                    )),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      color: AppPallete.buttonBlueColor,
                                    ),
                                    Text(
                                      " Logout",
                                      style: TextStyle(
                                        color: AppPallete.buttonBlueColor,
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  context.read<ClassifierCubit>().removeImage();
                                  context.read<AuthBloc>().add(
                                        AuthLogOut(),
                                      );
                                  setState(() {});
                                },
                              )
                            ],
                            content: Text("Are you sure you want to logout ?"),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: AppPallete.buttonBlueColor,
                          ),
                          Text(
                            " Logout",
                            style: TextStyle(
                              color: AppPallete.buttonBlueColor,
                            ),
                          ),
                        ],
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
