import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_search/features/classifier/presentation/cubit/classifier_cubit.dart';

import 'core/common/cubits/app_user/app_user_cubit.dart';
import 'core/theme/theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/discover/presentation/cubit/discover_cubit.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/products/presentation/cubit/product_cubit.dart';
import 'init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<CartCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<ClassifierCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<DiscoverCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<ProductCubit>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Visual Search System',
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            context.read<DiscoverCubit>().getAllCategories();
            context.read<ProductCubit>().getAllProducts();
            return const HomePage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
