import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/container_move/bloc/container_move_state.dart';
import 'package:mobile_warehouse/presentation/container_move/domain/repositories/container_move_repository.dart';

class ContainerMoveBloc extends Cubit<ContainerMoveState> {
  ContainerMoveBloc({
    required this.containerMoveRepository,
    required this.persistenceService,
  }) : super(ContainerMoveState());

  final ContainerMoveRepository containerMoveRepository;
  final PersistenceService persistenceService;
}
