import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_storage_info/flutter_storage_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'free_disk_space.freezed.dart';

@freezed
class FreeDiskSpaceEvent with _$FreeDiskSpaceEvent {
  const FreeDiskSpaceEvent._();

  const factory FreeDiskSpaceEvent.read() = _ReadFreeDiskSpaceEvent;
}

@freezed
class FreeDiskSpaceState with _$FreeDiskSpaceState {
  const FreeDiskSpaceState._();

  const factory FreeDiskSpaceState.progress({required final double space}) = _ProgressFreeDiskSpaceState;

  const factory FreeDiskSpaceState.error({required final String error, required final double space}) =
      _ErrorFreeDiskSpaceState;

  const factory FreeDiskSpaceState.success({required final double space}) = _SuccessFreeDiskSpaceState;
}

class FreeDiskSpaceBloc extends Bloc<FreeDiskSpaceEvent, FreeDiskSpaceState> {
  FreeDiskSpaceBloc() : super(const FreeDiskSpaceState.progress(space: 0)) {
    on<FreeDiskSpaceEvent>(
      (event, emit) => event.mapOrNull(
        read: (event) => _read(event, emit),
      ),
    );
  }

  Future<void> _read(_ReadFreeDiskSpaceEvent event, Emitter<FreeDiskSpaceState> emit) async {
    emit(FreeDiskSpaceState.progress(space: state.space));
    try {
      final space = await FlutterStorageInfo.getExternalStorageFreeSpaceInGB;

      emit(FreeDiskSpaceState.success(space: space));
    } on Object catch (e) {
      emit(FreeDiskSpaceState.error(error: e.toString(), space: state.space));
      rethrow;
    }
  }
}
