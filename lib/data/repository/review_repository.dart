import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_search/data/model/review.dart';

class ReviewRepository {
  const ReviewRepository();

  final colection = 'reviews';

  Future<List<Review>> getAllReviewsByLatLng(double lat, double lng) async {
    final colRef = FirebaseFirestore.instance.collection(colection);
    final querySnapshot = await colRef
        .where('mapX', isEqualTo: lng)
        .where('mapY', isEqualTo: lat)
        .get();
    return querySnapshot.docs.map((e) => Review.fromJson(e.data())).toList();
  }

  Future<Review?> save({
    required String content,
    required double mapX,
    required double mapY,
  }) async {
    try {
      final colRef = FirebaseFirestore.instance.collection(colection);
      final docRef = colRef.doc();
      final review = Review(
        id: docRef.id,
        content: content,
        mapX: mapX,
        mapY: mapY,
        createdAt: DateTime.now(),
      );
      await docRef.set(review.toJson());
      return review;
    } catch (e) {
      log('ReviewRepository : save : $e');
      return null;
    }
  }
}
