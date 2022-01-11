import 'package:flutter_bloc/flutter_bloc.dart';

import 'application_state.dart';

class ApplicationBloc extends Cubit<ApplicationState> {
  ApplicationBloc() : super(ApplicationState());
}
