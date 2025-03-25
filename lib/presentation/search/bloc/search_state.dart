part of 'search_cubit.dart';

class SearchState extends Equatable {
  final List<LocationModel> filteredItems;
  final bool isDropdownVisible;
  final String query;
  final bool isLoading;
  final String? errorMessage;

  const SearchState({
    this.filteredItems = const [],
    this.isDropdownVisible = false,
    this.query = '',
    this.isLoading = false,
    this.errorMessage,
  });

  SearchState copyWith({
    List<LocationModel>? filteredItems,
    bool? isDropdownVisible,
    String? query,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SearchState(
      filteredItems: filteredItems ?? this.filteredItems,
      isDropdownVisible: isDropdownVisible ?? this.isDropdownVisible,
      query: query ?? this.query,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [filteredItems, isDropdownVisible, query, isLoading, errorMessage];
}
