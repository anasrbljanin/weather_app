import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/model/location_model.dart';
import 'package:weather_app/design/colors.dart';
import 'package:weather_app/design/strings.dart';
import 'package:weather_app/design/text_styles.dart';
import 'package:weather_app/presentation/search/bloc/search_cubit.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({required this.onItemSelected, super.key});

  final Function(LocationModel) onItemSelected;

  @override
  createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          final cubit = context.read<SearchCubit>();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: WeatherString.searchForCity,
                  labelStyle: WeatherTextStyle.defaultTextStyle(
                      color: WeatherColor.hintTextBlack),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 24,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  suffixIcon: state.isLoading
                      ? Padding(
                          padding: EdgeInsets.all(12),
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : null,
                ),
                onChanged: (value) {
                  cubit.onSearchChanged(value);
                },
              ),
              if (state.isDropdownVisible)
                Container(
                  margin: EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: WeatherColor.labelGrey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    children: state.filteredItems.map((item) {
                      return ListTile(
                        title: Text('${item.name},${item.country}'),
                        onTap: () {
                          _controller.text = item.name ?? '';
                          cubit.onItemSelected(item);
                          widget.onItemSelected(item);
                        },
                      );
                    }).toList(),
                  ),
                ),
              if (state.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state.errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
