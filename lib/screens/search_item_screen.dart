import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../models/dummy_data.dart';

import '../widgets/meal_item.dart';

class SearchItemList extends StatefulWidget {
  static const routeName = 'search_item';

  @override
  State<SearchItemList> createState() => _SearchItemListState();
}

class _SearchItemListState extends State<SearchItemList> {
  late List categoryTitle;
  late List<Meal> DisplayedMeal;
  List<Meal> availableMeal = DUMMY_MEALS;

  @override
  void didChangeDependencies() {
    final argRoutes = ModalRoute.of(context)?.settings.arguments;

    categoryTitle = argRoutes as List;

    DisplayedMeal = availableMeal.where((meal) {
      return meal.categories.contains(argRoutes[0]);
    }).toList();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle[1].toString()),
      ),
      body: ListView.builder(
        itemCount: DisplayedMeal.length,
        itemBuilder: (BuildContext context, int index) {
          return MealItem(
            id: DisplayedMeal[index].id,
            title: DisplayedMeal[index].title,
            imageUrl: DisplayedMeal[index].imageUrl,
            duration: DisplayedMeal[index].duration,
            affordability: DisplayedMeal[index].affordability,
            complexity: DisplayedMeal[index].complexity,
          );
        },
      ),
    );
  }
}
