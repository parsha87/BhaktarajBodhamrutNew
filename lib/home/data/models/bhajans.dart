import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Bhajans extends Equatable {
  const Bhajans(
      {required this.alternateName,
      required this.bhajanLangType,
      required this.bhajanType,
      required this.displayName,
      required this.filepath,
      required this.id,
      //required this.index,
      required this.lyrics,
      required this.name,
      required this.size});

  final String alternateName;
  final String bhajanLangType;
  final String bhajanType;
  final String displayName;
  final String filepath;
  final String id;
 // final String index;
  final String lyrics;
  final String name;
  final int size;

  factory Bhajans.fromMap(Map<String, dynamic> json) {
    return Bhajans(
      alternateName: json['alternateName'] as String,
      bhajanLangType: json['bhajanLangType'] as String,
      bhajanType: json['bhajanType'] as String,
      displayName: json['displayName'] as String,
      filepath: json['filepath'] as String,
      id: json['id'] as String,
     // index: json['index'] as String,
      lyrics: json['lyrics'] as String,
      name: json['name'] as String,
      size: json['size'] as int,
    );
  }

  //create toMap method
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'alternateName': alternateName,
      'bhajanLangType': bhajanLangType,
      'bhajanType': bhajanType,
      'displayName': displayName,
      'filepath': filepath,
      'id': id,
    //  'index': index.toString(),
      'lyrics':lyrics,
      'name':name,
      'size':size
    };
  }

  @override
  List<Object?> get props => [
        alternateName,
        bhajanLangType,
        bhajanType,
        displayName,
        filepath,
        id,
       // index,
        lyrics,
        name,
        size
      ];
}
