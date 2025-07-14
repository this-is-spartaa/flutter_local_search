import 'package:flutter/material.dart';
import 'package:flutter_local_search/data/model/location.dart';
import 'package:flutter_local_search/ui/review/review_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key, required this.location});

  final Location location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.title),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(reviewViewModel(location));
          final viewModel = ref.read(reviewViewModel(location).notifier);
          return ListView();
        },
      ),
    );
  }
}
