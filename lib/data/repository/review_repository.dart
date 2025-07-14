import 'package:flutter_local_search/data/model/review.dart';

class ReviewRepository {
  const ReviewRepository();
  Future<List<Review>> getAllReviewsByLatLng(double lat, double lng) async {
    return [];
  }

  Future<Review?> save({
    required String content,
    required double mapX,
    required double mapY,
  }) async {
    return null;
  }
}
