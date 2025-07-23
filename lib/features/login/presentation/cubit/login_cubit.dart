import 'dart:developer';

import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/core/database/hive_storage_service.dart';
import 'package:e_commerce_app/core/network/model/either.dart';
import 'package:e_commerce_app/core/network/network_service.dart';
import 'package:e_commerce_app/features/login/data/models/login_request.dart';
import 'package:e_commerce_app/features/login/data/models/login_response.dart';
import 'package:e_commerce_app/features/login/data/models/user_data_model.dart';
import 'package:e_commerce_app/features/login/domain/usecases/login_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final HiveService _hiveService;
  final NetworkService _networkService;
  List<UserDataModel> allUserData = [];
  int userId =0;

  LoginCubit(this._loginUseCase)
    : _hiveService = GetIt.instance<HiveService>(),
      _networkService = GetIt.instance<NetworkService>(),
      super(LoginLoaded()) {
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    Either result = await _loginUseCase.getUserData();
    result.fold(
      (failure) {
        log(failure.message);
      },
      (userData) {
        allUserData = userData;
      },
    );
  }

  void validate(String username, String password) {
    final currentState = state;
    if (currentState is LoginLoaded) {
      String usernameError = '';
      String passwordError = '';

      if (username.isEmpty) {
        usernameError = "ENTER_THE_USERNAME".tr;
      }
      if (password.isEmpty) {
        passwordError = "ENTER_THE_PASSWORD".tr;
      }

      if (usernameError.isNotEmpty || passwordError.isNotEmpty) {
        emit(
          currentState.copyWith(
            usernameError: usernameError,
            passwordError: passwordError,
          ),
        );
      } else {
        LoginRequest request = LoginRequest(
          username: username,
          password: password,
        );

        final filteredUser = allUserData.where((u) => u.username == username && u.password == password).toList();
        if (filteredUser.isNotEmpty) {
          final user = filteredUser.first;
          userId = user.id;
          emit(currentState.copyWith(userId: user.id));
        }
        login(request);
      }
    }
  }

  Future<void> login(LoginRequest user) async {
    final currentState = state as LoginLoaded;
    emit(currentState.copyWith(isLoading: true));
    Either result = await _loginUseCase.login(user: user);
    result.fold(
      (error) {
        if (kDebugMode) {
          print(error.identifier);
        }
        emit(
          currentState.copyWith(
            errorMessage: error.message,
            isLoading: false,
            isError: true,
          ),
        );
      },
      (user) {
        if (user != null) {
          LoginResponse response = user as LoginResponse;
          String token = response.token;
          _hiveService.set(userToken, token);
          _hiveService.setUserId(userId);
          //_hiveService.setUser(response.data!);
          // if (response.data?.faceId != null ||
          // response.data?.fingerPrintId != null) {
          // _hiveService.set(localAuth, enable);
          // if (response.data?.faceId != null) {
          //   _hiveService.set(faceIdAuth, enable);
          // } else if (response.data?.fingerPrintId != null) {
          //   _hiveService.set(fingerPrintAuth, enable);
          // }
          // }
          _networkService.updateHeader({'x-access-token': token});
          emit(LoginSuccess(user));

        } else {
          emit(
            currentState.copyWith(
              errorMessage: 'Internal Error occurred',
              isLoading: false,
              isError: true,
            ),
          );
        }
      },
    );
  }

  validateName(String value) {
    String error = '';
    final currentState = state;
    if (value.isEmpty) {
      error = "NAME_VALIDATION_TEXT".tr;
    }
    if (currentState is LoginLoaded) {
      emit(currentState.copyWith(usernameError: error));
    }
  }

  validatePassword(String value) {
    String error = '';
    final currentState = state;
    if (value.isEmpty) {
      error = "PASSWORD_VALIDATION_TEXT".tr;
    }
    if (currentState is LoginLoaded) {
      emit(currentState.copyWith(passwordError: error));
    }
  }

  void resetError() {
    final currentState = state as LoginLoaded;
    emit(currentState.copyWith(isLoading: false, isError: false));
  }
}
