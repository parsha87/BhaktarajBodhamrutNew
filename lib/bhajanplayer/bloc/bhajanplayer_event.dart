part of 'bhajanplayer_bloc.dart';

abstract class BhajanplayerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BhajanplayerEventFetch extends BhajanplayerEvent {}

class GetBhajanFromIdEvent extends BhajanplayerEvent {
  GetBhajanFromIdEvent(this.bhajanId);
  final String bhajanId;
}

class CheckBhakanExistsEvent extends BhajanplayerEvent {
  CheckBhakanExistsEvent(this.bhajanId, this.fileUrl);
  final String bhajanId;
  final String fileUrl;
}

class GetandDownloadBhajanFromUrlEvent extends BhajanplayerEvent {
  GetandDownloadBhajanFromUrlEvent(this.bhajanId, this.fileUrl);
  final String bhajanId;
  final String fileUrl;
}
