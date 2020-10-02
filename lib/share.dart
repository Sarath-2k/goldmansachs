import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';

class ShareProduct {
  String fileName;
  String downloadUrl;
  Uint8List bytes;

  ShareProduct(
      {@required this.fileName,
      @required this.downloadUrl,
      @required this.bytes});
}

shareOut(List<ShareProduct> shareProductList) async {
  Map<String, List<int>> mapToShare;

  mapToShare = Map.fromIterable(shareProductList,
      key: (e) => '${e.fileName}.jpg', value: (e) => e.bytes);
  print(mapToShare);
  try {
    await Share.files('BB GOLD', mapToShare, '*/*', text: 'Share from BB GOLD');
  } catch (e) {
    print('error: $e');
  }
}


Future<Uint8List> getBytes(String downloadUrl) async {
  var request = await HttpClient().getUrl(Uri.parse(downloadUrl));
  var response = await request.close();
  var bytesTemp = await consolidateHttpClientResponseBytes(response);
  print('bytes cosnolidation done');
  return bytesTemp;
}

