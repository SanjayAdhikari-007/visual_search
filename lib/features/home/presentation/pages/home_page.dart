import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/constants.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../classifier/presentation/cubit/classifier_cubit.dart';
import '../../../classifier/presentation/cubit/classifier_state.dart';
import '../../../classifier/presentation/pages/dialog.dart';
import '../components/pages.dart';

class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<ClassifierCubit>().initialize();
  }

  @override
  Widget build(BuildContext context) {
    SvgPicture svgIcon(String src, {Color? color}) {
      return SvgPicture.asset(
        src,
        height: 24,
        colorFilter: ColorFilter.mode(
            color ??
                Theme.of(context).iconTheme.color!.withValues(
                    alpha: Theme.of(context).brightness == Brightness.dark
                        ? 0.3
                        : 1),
            BlendMode.srcIn),
      );
    }

    return SafeArea(
      child: Scaffold(
        // body: _pages[_currentIndex],
        body: PageTransitionSwitcher(
          duration: defaultDuration,
          transitionBuilder: (child, animation, secondAnimation) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondAnimation,
              child: child,
            );
          },
          child: pages[_currentIndex],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(top: defaultPadding / 2),
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF101015),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              if (index != _currentIndex) {
                setState(() {
                  _currentIndex = index;
                });
              }
            },
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : const Color(0xFF101015),
            type: BottomNavigationBarType.fixed,
            // selectedLabelStyle: TextStyle(color: primaryColor),
            selectedFontSize: 12,
            selectedItemColor: primaryColor,
            unselectedItemColor: Colors.transparent,
            items: [
              BottomNavigationBarItem(
                icon: svgIcon("assets/icons/Shop.svg"),
                activeIcon:
                    svgIcon("assets/icons/Shop.svg", color: primaryColor),
                label: "Shop",
              ),
              BottomNavigationBarItem(
                icon: svgIcon("assets/icons/Category.svg"),
                activeIcon:
                    svgIcon("assets/icons/Category.svg", color: primaryColor),
                label: "Discover",
              ),
              BottomNavigationBarItem(
                icon: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    if (state is CartLoaded && state.itemCount != 0) {
                      return Stack(children: [
                        svgIcon("assets/icons/Bag.svg"),
                        Positioned(
                          right: 0,
                          left: 8,
                          top: 3.3,
                          bottom: 0,
                          child: Text(
                            state.itemCount.toString(),
                            style:
                                TextStyle(fontSize: 13, color: Colors.white38),
                          ),
                        )
                      ]);
                    }
                    return svgIcon(
                      "assets/icons/Bag.svg",
                    );
                  },
                ),
                activeIcon: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    if (state is CartLoaded && state.itemCount != 0) {
                      return Stack(children: [
                        svgIcon("assets/icons/Bag.svg", color: primaryColor),
                        Positioned(
                          right: 0,
                          left: 8,
                          top: 3.3,
                          bottom: 0,
                          child: Text(
                            state.itemCount.toString(),
                            style: TextStyle(fontSize: 13, color: primaryColor),
                          ),
                        )
                      ]);
                    }
                    return svgIcon("assets/icons/Bag.svg", color: primaryColor);
                  },
                ),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: svgIcon("assets/icons/Profile.svg"),
                activeIcon:
                    svgIcon("assets/icons/Profile.svg", color: primaryColor),
                label: "Profile",
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: BlocBuilder<ClassifierCubit, ClassifierState>(
          builder: (context, state) {
            if (state is ClassifierSuccess) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.search),
                  Container(
                    height: 25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        image: DecorationImage(
                          image: FileImage(state.imageFile),
                          fit: BoxFit.cover,
                        )),
                  ),
                ],
              );
            }
            return Icon(Icons.search);
          },
        ), onPressed: () {
          showVisualSearchDialog(context);
        }),
      ),
    );
  }
}
