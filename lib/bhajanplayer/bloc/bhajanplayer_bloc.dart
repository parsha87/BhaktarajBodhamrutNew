import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bodhamrut/home/data/models/bhajans.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../data/repository/bhajan_player_repository.dart';

part 'bhajanplayer_event.dart';
part 'bhajanplayer_state.dart';

class BhajanplayerBloc extends Bloc<BhajanplayerEvent, BhajanplayerState> {
  BhajanplayerBloc({required this.bhajanRepository}) : super(BhajanplayerInitial()) {
    on<GetBhajanFromIdEvent>(_fetchBhajan);
    on<GetandDownloadBhajanFromUrlEvent>(_getBhajanorDownload);
  }
  final BhajanRepository bhajanRepository;

  FutureOr<void> _fetchBhajan(GetBhajanFromIdEvent event,Emitter<BhajanplayerState> emit)
   async {
          emit(BhajanplayerLoading());
          try {
                final Bhajans bhajans = await bhajanRepository.getBhajanFromId(event.bhajanId);
                emit(BhajanPlayerSuccess(bhajan: bhajans));
              }
          catch (e)
           {
                emit(BhajanViewError(message: e.toString()));
            }
        }

  FutureOr<void> _getBhajanorDownload(
    GetandDownloadBhajanFromUrlEvent event,
    Emitter<BhajanplayerState> emit,
  ) async {
    emit(BhajanplayerLoading());
    try {
      Stream<FileResponse> fileStream =
          await bhajanRepository.getBhajanFromUrl(event.fileUrl);
      emit(BhajanDownloadSuccess(fileStream: fileStream));
    } catch (e) {
      emit(BhajanViewError(message: e.toString()));
    }
  }
}
