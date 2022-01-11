import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/presentation/splash/bloc/splashscreen_state.dart';

class SplashScreenBloc extends Cubit<SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenState());

  void loadSplashScreen() {
    emit(state.copyWith(isLoading: true));

    Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      emit(state.copyWith(isLoading: false));
    });
  }
}
