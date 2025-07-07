import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:visual_search/features/auth/domain/usecases/user_logout.dart';
import 'package:visual_search/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:visual_search/features/classifier/presentation/cubit/classifier_cubit.dart';
import 'package:visual_search/features/discover/presentation/cubit/discover_cubit.dart';

import 'core/common/cubits/app_user/app_user_cubit.dart';
import 'core/network/connection_checker.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/usecases/current_user.dart';
import 'features/auth/domain/usecases/user_login.dart';
import 'features/auth/domain/usecases/user_sign_up.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/classifier/data/repository/multi_classifier_repository.dart';
import 'features/discover/data/datasource/category_data_source.dart';
import 'features/discover/data/repository/catergory_repository_impl.dart';
import 'features/discover/domain/repository/category_repository.dart';
import 'features/products/data/datasources/product_data_source.dart';
import 'features/products/data/repository/product_repository_impl.dart';
import 'features/products/domain/repository/product_repository.dart';
import 'features/products/presentation/cubit/product_cubit.dart';

part 'init_dependencies.main.dart';
