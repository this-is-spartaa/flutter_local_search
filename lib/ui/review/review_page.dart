import 'package:flutter/material.dart';
import 'package:flutter_local_search/data/model/location.dart';
import 'package:flutter_local_search/ui/review/review_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewPage extends ConsumerStatefulWidget {
  const ReviewPage({super.key, required this.location});

  final Location location;

  @override
  ConsumerState<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends ConsumerState<ReviewPage> {
  final textController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reviews = ref.watch(reviewViewModel(widget.location)).reviews;
    final viewModel = ref.read(reviewViewModel(widget.location).notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.location.title),
      ),
      backgroundColor: Colors.white,
      bottomSheet: Container(
        height: 50,
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        child: TextField(
          controller: textController,
          onSubmitted: (value) {
            viewModel.write(value);
            textController.clear();
          },
        ),
      ),
      body: Builder(
        builder: (context) {
          if (reviews == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (reviews.isEmpty) {
            return const Center(
              child: Text('작성된 리뷰가 없습니다.'),
            );
          }
          return ListView.separated(
            itemCount: reviews.length,
            padding: EdgeInsets.all(20),
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemBuilder: (context, index) {
              final review = reviews[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey[300]!,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.content,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${review.createdAt}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
