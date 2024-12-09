import 'package:dio/dio.dart';
import 'package:flutter_local_search/data/model/location.dart';

class LocationRepository {
  const LocationRepository();
  Future<List<Location>> searchLocation(String query) async {
    final Dio dioClient = Dio(BaseOptions(
      validateStatus: (status) => true,
    ));
    final response =
        await dioClient.get('https://openapi.naver.com/v1/search/local.json',
            queryParameters: {
              'query': query,
              'display': 5,
            },
            options: Options(
              headers: {
                'X-Naver-Client-Id': 'MpN9F_cJAAjiqzvKWbZL',
                'X-Naver-Client-Secret': 'XRD75_zFj0',
              },
            ));

    if (response.statusCode == 200) {
      return List.from(response.data['items'])
          .map((e) => Location.fromJson(e))
          .toList();
    }

    return [];
  }
}


// {
//   "lastBuildDate": "Mon, 09 Dec 2024 18:43:49 +0900",
//   "total": 5,
//   "start": 1,
//   "display": 5,
//   "items": [
//     {
//       "title": "삼성1동 주민센터",
//       "link": "http://www.gangnam.go.kr/center/main.do?office=3220047",
//       "category": "공공,사회기관>행정복지센터",
//       "description": "",
//       "telephone": "",
//       "address": "서울특별시 강남구 삼성1동 161-2",
//       "roadAddress": "서울특별시 강남구 봉은사로 616 삼성1동 주민센터",
//       "mapx": "1270625320",
//       "mapy": "375144424"
//     },
//     {
//       "title": "삼성2동 주민센터",
//       "link": "http://www.gangnam.go.kr/center/main.do?office=3220048",
//       "category": "공공,사회기관>행정복지센터",
//       "description": "",
//       "telephone": "",
//       "address": "서울특별시 강남구 삼성동 38-34",
//       "roadAddress": "서울특별시 강남구 봉은사로 419 삼성2동주민센터",
//       "mapx": "1270459499",
//       "mapy": "375111999"
//     },
//     {
//       "title": "코엑스",
//       "link": "http://www.coex.co.kr/",
//       "category": "문화,예술>컨벤션센터",
//       "description": "",
//       "telephone": "",
//       "address": "서울특별시 강남구 삼성동 159",
//       "roadAddress": "서울특별시 강남구 영동대로 513",
//       "mapx": "1270594274",
//       "mapy": "375116620"
//     },
//     {
//       "title": "별마당 도서관",
//       "link": "https://m.starfield.co.kr/coexmall/tenant/starfieldLibrary",
//       "category": "교육,학문>도서관",
//       "description": "",
//       "telephone": "",
//       "address": "서울특별시 강남구 삼성동 159 스타필드 코엑스몰 B1",
//       "roadAddress": "서울특별시 강남구 영동대로 513 스타필드 코엑스몰 B1",
//       "mapx": "1270601820",
//       "mapy": "375100516"
//     },
//     {
//       "title": "현대백화점 무역센터점",
//       "link": "https://www.ehyundai.com/newPortal/index.do",
//       "category": "쇼핑,유통>백화점",
//       "description": "",
//       "telephone": "",
//       "address": "서울특별시 강남구 삼성동 159-7",
//       "roadAddress": "서울특별시 강남구 테헤란로 517",
//       "mapx": "1270599078",
//       "mapy": "375085856"
//     }
//   ]
// }