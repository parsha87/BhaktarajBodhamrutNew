import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../../home/data/models/bhajans.dart';


class BhajanRepository {
  final bhajanCollectionRed =FirebaseFirestore.instance.collection('babaSBhajans');

  Future<Bhajans> getBhajanFromId(String id) async {
    final fetchedProduct = await bhajanCollectionRed.doc(id).get().then((value) {
      final bhajanData = value.data();      
      return Bhajans.fromMap(bhajanData as Map<String, dynamic> );
    });
    return fetchedProduct;
  }

  Future<Stream<FileResponse>> getBhajanFromUrl(String fileUrl) async {
     Stream<FileResponse> fileStream = DefaultCacheManager()
          .getFileStream(fileUrl, withProgress: true);
      return fileStream;
    } 

}
