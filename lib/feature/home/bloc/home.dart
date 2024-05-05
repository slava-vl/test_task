import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/model/place.dart';
import '../data/repository/home_repository.dart';

part 'home.freezed.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const HomeEvent._();

  const factory HomeEvent.read() = _ReadHomeEvent;

  const factory HomeEvent.refresh() = _RefreshHomeEvent;
}

@freezed
class HomeState with _$HomeState {
  const HomeState._();

  const factory HomeState.progress({final Place? place}) = _ProgressHomeState;

  const factory HomeState.error({required final String error}) = _ErrorHomeState;

  const factory HomeState.success({required final Place place}) = _SuccessHomeState;
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IHomeRepository _repository;
  HomeBloc({required final IHomeRepository repository})
      : _repository = repository,
        super(const HomeState.progress()) {
    on<HomeEvent>(
      (event, emit) => event.mapOrNull(
        read: (event) => _read(event, emit),
        refresh: (event) => _refresh(event, emit),
      ),
    );
  }

  Future<void> _read(_ReadHomeEvent event, Emitter<HomeState> emit) async {
    try {
      final data = await _repository.readHome().timeout(const Duration(seconds: 30));

      emit(HomeState.success(place: data));
    } on Object catch (e) {
      emit(HomeState.error(error: e.toString()));
      rethrow;
    }
  }

  Future<void> _refresh(_RefreshHomeEvent event, Emitter<HomeState> emit) async {
    emit(const HomeState.progress());
    add(const HomeEvent.read());
  }
}
