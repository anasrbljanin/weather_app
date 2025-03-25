import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/model/location_model.dart';
import 'package:weather_app/data/weather_api_service.dart';
import 'package:weather_app/design/strings.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState());

  Future<void> onSearchChanged(String query) async {
    if (query.isEmpty) {
      emit(state.copyWith(filteredItems: [], isDropdownVisible: false));
      return;
    }

    emit(state.copyWith(isLoading: true));

    final List<LocationModel>? matches =
        await WeatherApiService.searchLocation(query);
    emit(matches != null
        ? state.copyWith(
            filteredItems: matches,
            isDropdownVisible: matches.isNotEmpty,
            isLoading: false,
          )
        : state.copyWith(
            isLoading: false, errorMessage: WeatherString.errorFetchingData));
  }

  void onItemSelected(LocationModel selectedLocation) {
    emit(state.copyWith(
      query: selectedLocation.name,
      isDropdownVisible: false,
      filteredItems: [],
    ));
  }
}
