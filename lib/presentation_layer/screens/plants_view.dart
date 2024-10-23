import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantiful/core/app_sizing.dart';
import 'package:plantiful/cubits/plants/plants_cubit.dart';
import 'package:plantiful/data_layer.dart/models/get_plants_response.dart';
import 'package:plantiful/presentation_layer/widgets/empty_list.dart';
import 'package:plantiful/presentation_layer/widgets/loading.dart';
import 'package:plantiful/presentation_layer/widgets/plants_grid.dart';
import 'package:plantiful/presentation_layer/widgets/something_went_wrong.dart';

class PlantsView extends StatefulWidget {
  const PlantsView({super.key});

  @override
  State<PlantsView> createState() => _PlantsViewState();
}

class _PlantsViewState extends State<PlantsView>
    with SingleTickerProviderStateMixin {
  List<Plant> plants = [];
  List<Plant> filterdList = [];
  var searchClearIcon;
  List<Plant> toBeDisplayedList = [];
  bool isSearching = false;
  late TextEditingController searchingController;
  @override
  void initState() {
    PlantsCubit.get(context).getAllPlants();
    searchingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    searchClearIcon =
        isSearching ? const Icon(Icons.clear) : const Icon(Icons.search);
    toBeDisplayedList = searchingController.text.isEmpty ? plants : filterdList;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: AppSpacingSizing.s64,
              centerTitle: true,
              title: isSearching ? searchInputField() : const Text("Plants"),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacingSizing.s16),
                  child: IconButton(
                      onPressed: () => search(), icon: searchClearIcon),
                )
              ],
            ),
            body: BlocConsumer<PlantsCubit, PlantsState>(
              listener: (context, state) {
                state is PlantsSuccess
                    ? plants = PlantsCubit.get(context).plants
                    : null;
                toBeDisplayedList = plants;
              },
              builder: (context, state) {
                return state is PlantsLoading
                    ? Loading(
                        color: Theme.of(context).primaryColor,
                      )
                    : state is PlantsFailure
                        ? SomethingWentWrong(
                            onPressed: () =>
                                PlantsCubit.get(context).getAllPlants())
                        : toBeDisplayedList.isEmpty
                            ? const EmptyList(text: "No Results")
                            : PlantsGrid(toBeDisplayedList: toBeDisplayedList);
              },
            )));
  }

  Widget searchInputField() {
    return TextField(
      controller: searchingController,
      keyboardAppearance: Brightness.dark,
      showCursor: true,
      decoration: const InputDecoration(
          hintText: "Search",
          hintStyle: TextStyle(
            letterSpacing: 0.7,
            fontSize: 18,
          ),
          border: InputBorder.none,
          hintFadeDuration: Duration(milliseconds: 400)),
      onChanged: (value) => filterBooks(value),
    );
  }

  void filterBooks(String searchPrompt) {
    setState(() {
      filterdList = plants
          .where((plant) =>
              plant.name.toLowerCase().contains(searchPrompt.toLowerCase()))
          .toList();
    });
  }

  void search() {
    if (isSearching) {
      clearSearchBar();
    } else {
      showSearchBar();
    }
  }

  void clearSearchBar() {
    searchingController.clear();
    filterdList.clear;
    setState(() {
      filterdList.addAll(plants);
    });
  }

  void showSearchBar() {
    setState(() {
      isSearching = true;
    });
    ModalRoute.of(context)!.addLocalHistoryEntry(
        LocalHistoryEntry(onRemove: () => closeSearchBar()));
  }

  void closeSearchBar() {
    searchingController.clear();
    filterdList.clear;
    setState(() {
      filterdList.addAll(plants);
      isSearching = false;
    });
  }
}
