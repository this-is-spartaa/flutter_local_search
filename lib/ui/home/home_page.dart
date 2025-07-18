import 'package:flutter/material.dart';
import 'package:flutter_local_search/core/geolocator_helper.dart';
import 'package:flutter_local_search/ui/review/review_page.dart';
import 'package:flutter_local_search/ui/home/home_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final homeState = ref.watch(homeViewModel);
      final viewModel = ref.read(homeViewModel.notifier);
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            actions: [
              GestureDetector(
                onTap: () async {
                  final position = await GeolocatorHelper.getPosition();
                  if (position != null) {
                    viewModel.searchByLatLng(
                        position.latitude, position.longitude);
                  }
                },
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Icon(Icons.gps_fixed),
                ),
              )
            ],
            title: TextField(
              maxLines: 1,
              onSubmitted: (value) {
                viewModel.searchLocation(value);
              },
              decoration: InputDecoration(
                hintText: '검색어를 입력해 주세요',
                border: WidgetStateInputBorder.resolveWith(
                  (states) {
                    if (states.contains(WidgetState.focused)) {
                      return OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black),
                      );
                    }
                    return OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
          ),
          body: ListView.separated(
            padding: EdgeInsets.all(20),
            itemCount: homeState.locations.length,
            separatorBuilder: (context, index) => SizedBox(height: 20),
            itemBuilder: (context, index) {
              final location = homeState.locations[index];
              return GestureDetector(
                onTap: () {
                  if (location.link.startsWith('https')) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ReviewPage(location: location);
                        },
                      ),
                    );
                  }
                },
                child: Container(
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
                        location.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(location.category),
                      Text(location.roadAddress),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
