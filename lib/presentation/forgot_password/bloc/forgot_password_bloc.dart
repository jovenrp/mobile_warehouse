import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/forgot_password/bloc/forgot_password_state.dart';

class ForgotPasswordBloc extends Cubit<ForgotPasswordState> {
  ForgotPasswordBloc({
    required this.persistenceService,
  }) : super(ForgotPasswordState());

  final PersistenceService persistenceService;

  Future<void> init() async {
    emit(state.copyWith(
        isLoading: false, hasError: false, errorMessage: '', isSuccess: false));
  }

  Future<void> submitEmail(String email) async {
    emit(state.copyWith(isLoading: true, hasError: false));

    Timer(const Duration(milliseconds: 500), () {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);

      if (emailValid) {
        emit(state.copyWith(
          isLoading: false,
          hasError: false,
          isSuccess: true,
        ));
      } else {
        emit(state.copyWith(
            isLoading: false,
            hasError: true,
            isSuccess: false,
            errorMessage: 'The email you entered is invalid.'));
      }
    });
  }
}
