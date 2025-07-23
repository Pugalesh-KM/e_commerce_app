
import 'package:e_commerce_app/core/database/hive_storage_service.dart';
import 'package:e_commerce_app/core/network/dio_network_service.dart';
import 'package:e_commerce_app/core/network/network_service.dart';
import 'package:e_commerce_app/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:e_commerce_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:e_commerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/cart_usecase.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/login/data/datasources/login_remote_data_sources.dart';
import 'package:e_commerce_app/features/login/data/repositories/login_repository_impl.dart';
import 'package:e_commerce_app/features/login/domain/repositories/login_repository.dart';
import 'package:e_commerce_app/features/login/domain/usecases/login_usecase.dart';
import 'package:e_commerce_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:e_commerce_app/features/product/data/datasources/product_remote_data_source.dart';
import 'package:e_commerce_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:e_commerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:e_commerce_app/features/product/domain/usecases/product_usecase.dart';
import 'package:e_commerce_app/features/product/presentation/cubit/product_cubit.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

Future<void> init() async{
  injector

    ..registerLazySingleton<NetworkService>(DioNetworkService.new)
    ..registerLazySingleton<DioNetworkService>(DioNetworkService.new)
    ..registerLazySingleton<HiveService>(HiveService.new)
    /// Login
    ..registerLazySingleton<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl( injector()))
    ..registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(injector()))
    ..registerLazySingleton<LoginUseCase>(() => LoginUseCase(injector()))
    ..registerFactory<LoginCubit>(() => LoginCubit(injector()))

    /// product
    ..registerLazySingleton<ProductRemoteDataSource>(() => ProductRemoteDataSourceImpl(injector()))
    ..registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(injector()))
    ..registerLazySingleton<ProductUseCase>(() => ProductUseCase(injector()))
    ..registerFactory<ProductCubit>(() => ProductCubit(injector()))

    /// cart
    ..registerLazySingleton<CartRemoteDataSource>(() => CartRemoteDataSourceImpl(injector()))
    ..registerLazySingleton<CartRepository>(() => CartRepositoryImpl(injector()))
    ..registerLazySingleton<CartUseCase>(() => CartUseCase(injector()))
    ..registerFactory<CartCubit>(() => CartCubit(injector()));

}