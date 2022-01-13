import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/core/domain/models/user_profile_model.dart';
import 'package:mobile_warehouse/presentation/splash/bloc/splashscreen_state.dart';

class SplashScreenBloc extends Cubit<SplashScreenState> {
  SplashScreenBloc({this.persistenceService}) : super(SplashScreenState());

  final PersistenceService? persistenceService;

  void loadSplashScreen() async {
    emit(state.copyWith(isLoading: true));

    UserProfileModel? userProfileModel =
        await persistenceService?.userProfile.get();
    String? token = await persistenceService?.dwnToken.get();

    Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      emit(state.copyWith(isLoading: false));
      if (token == null) {
        emit(state.copyWith(isAlreadySignedIn: false));
      } else {
        emit(state.copyWith(
            userProfileModel: userProfileModel,
            token: token,
            isAlreadySignedIn: true));
      }
    });
  }
}
