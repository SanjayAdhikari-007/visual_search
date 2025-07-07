part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initClassifier();
  _initAuth();
  _initCategory();
  _initProduct();

  serviceLocator.registerFactory(() => InternetConnection());

  // core
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      serviceLocator(),
    ),
  );
}

void _initAuth() {
  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogOut(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogOut: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initCategory() {
  // Datasource
  serviceLocator
    ..registerFactory<CategoryDataSource>(
      () => CategoryDataSourceImpl(),
    )
    // Repository
    ..registerFactory<CategoryRepository>(
      () => CategoryRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => DiscoverCubit(serviceLocator()),
    );
}

void _initProduct() {
  // Datasource
  serviceLocator
    ..registerFactory<ProductDataSource>(
      () => ProductDataSourceImpl(),
    )
    // Repository
    ..registerFactory<ProductRepository>(
      () => ProductRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => CartCubit(),
    )
    ..registerLazySingleton(
      () => ProductCubit(serviceLocator()),
    );
}

void _initClassifier() {
  // Repository
  serviceLocator.registerFactory<MultiModelClassifierRepository>(
    () => MultiModelClassifierRepository(),
  );
  serviceLocator.registerLazySingleton<ClassifierCubit>(
    () => ClassifierCubit(serviceLocator()),
  );
}
