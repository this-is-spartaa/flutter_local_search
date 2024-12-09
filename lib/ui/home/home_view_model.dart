import 'package:flutter_local_search/data/model/location.dart';
import 'package:flutter_local_search/data/repository/location_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeState {
  List<Location> locations;
  HomeState({required this.locations});
}

class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    return HomeState(locations: []);
  }

  final locationRepository = const LocationRepository();

  void searchLocation(String query) async {
    final result = await locationRepository.searchLocation(query);
    state = HomeState(locations: result);
  }
}

final homeViewModel =
    NotifierProvider<HomeViewModel, HomeState>(() => HomeViewModel());
