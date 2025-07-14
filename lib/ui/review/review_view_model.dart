import 'package:flutter_local_search/data/model/location.dart';
import 'package:flutter_local_search/data/model/review.dart';
import 'package:flutter_local_search/data/repository/review_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewState {
  List<Review>? reviews;
  ReviewState({required this.reviews});
}

class ReviewViewModel extends AutoDisposeFamilyNotifier<ReviewState, Location> {
  @override
  ReviewState build(Location arg) {
    return ReviewState(reviews: []);
  }

  final reviewRepository = const ReviewRepository();

  void getAllReviews() async {
    final result = await reviewRepository.getAllReviewsByLatLng(
      double.parse(arg.mapx),
      double.parse(arg.mapx),
    );
    state = ReviewState(reviews: result);
  }

  void write(String content) async {
    final result = await reviewRepository.save(
      content: content,
      mapX: double.parse(arg.mapx),
      mapY: double.parse(arg.mapx),
    );

    if (result != null) {
      state = ReviewState(reviews: [
        ...state.reviews ?? [],
        result,
      ]);
    }
  }
}

final reviewViewModel = NotifierProvider.autoDispose
    .family<ReviewViewModel, ReviewState, Location>(() => ReviewViewModel());
