import 'dart:developer';

import 'package:dio/dio.dart';

class VworldRepository {
  const VworldRepository();

  Future<List<String>> findByLatLng(double lat, double lng) async {
    final Dio dioClient = Dio(BaseOptions(
      validateStatus: (status) => true,
    ));
    try {
      final response = await dioClient.get(
        'https://api.vworld.kr/req/data',
        queryParameters: {
          'request': 'GetFeature',
          'key': 'F8535CD0-9ACB-38AE-9D71-48E363366BD0',
          'data': 'LT_C_ADEMD_INFO',
          'geomFilter': 'POINT($lng $lat)',
          'geometry': false,
          'size': 100,
        },
      );

      if (response.statusCode == 200 &&
          response.data['response']['status'] == 'OK') {
        // Response > result > featureCollection > features >> properties > full_nm
        final features = response.data['response']['result']
            ['featureCollection']['features'];
        final featureList = List.from(features);
        final iterable = featureList.map((feat) {
          return '${feat['properties']['full_nm']}';
        });
        return iterable.toList();
      }
      return [];
    } catch (e) {
      log('$e');
      return [];
    }
  }
}

// {
//   "response": {
//     "service": {
//       "name": "data",
//       "version": "2.0",
//       "operation": "GetFeature",
//       "time": "19(ms)"
//     },
//     "status": "OK",
//     "record": {
//       "total": "1",
//       "current": "1"
//     },
//     "page": {
//       "total": "1",
//       "current": "1",
//       "size": "100"
//     },
//     "result": {
//       "featureCollection": {
//         "type": "FeatureCollection",
//         "bbox": [
//           0.0,
//           0.0,
//           -1.0,
//           -1.0
//         ],
//         "features": [
//           {
//             "type": "Feature",
//             "properties": {
//               "emd_eng_nm": "Oncheon-dong",
//               "emd_kor_nm": "온천동",
//               "full_nm": "부산광역시 동래구 온천동",
//               "emd_cd": "26260108"
//             },
//             "id": "LT_C_ADEMD_INFO.314177"
//           }
//         ]
//       }
//     }
//   }
// }