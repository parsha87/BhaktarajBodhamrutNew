part of 'bhajanplayer_bloc.dart';

abstract class BhajanplayerState extends Equatable {

  @override
  List<Object> get props => [];
}

class BhajanplayerInitial extends BhajanplayerState {}
class BhajanplayerLoading extends BhajanplayerState {}
class BhajanDownlodedCheck extends BhajanplayerState {}
class BhajanDownloading extends BhajanplayerState {}

class BhajanPlayerSuccess extends BhajanplayerState {
  BhajanPlayerSuccess({required this.bhajan});
  final Bhajans bhajan;
  }


class BhajanDownloadSuccess extends BhajanplayerState {
  BhajanDownloadSuccess({required this.fileStream});
  final Stream<FileResponse> fileStream;
}

class BhajanViewError extends BhajanplayerState {
  BhajanViewError({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}