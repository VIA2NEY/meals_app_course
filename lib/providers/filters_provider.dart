import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter {
  glutenfree,
  lactosefree,
  vegetarian,
  vegan
}


class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  
  FiltersNotifier() : super({
    Filter.glutenfree: false ,
    Filter.lactosefree: false,
    Filter.vegetarian: false ,
    Filter.vegan: false,
  });

  void setFilter(Filter filter, bool isActive){
    state = {
      ...state,
      filter: isActive
    };
  }

  void setFilters(Map<Filter, bool> chosenFilters){
    state = chosenFilters;
  }

}

final filtersProvider = StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier()
);

final filteredMealsProvider = Provider(
  (ref) {

    final meals = ref.watch(mealsprovider);
    final activefilter = ref.watch(filtersProvider);

    return meals.where((meal) {

      // Si la valeur de la filterScreen(_selectedFilter) a pour valeur Filter.glutenfree = true 
      // et que l'element de la rechercher .where (meal) n'est pas sans glutten (!meal.isGlutenFree)
      if (activefilter[Filter.glutenfree]! && !meal.isGlutenFree) {
        return false; // Donc je ne l'inclus pas 
      }

      if (activefilter[Filter.lactosefree]! && !meal.isLactoseFree) {
        return false; // Donc je ne l'inclus pas 
      }

      if (activefilter[Filter.vegetarian]! && !meal.isVegetarian) {
        return false; // Donc je ne l'inclus pas 
      }

      if (activefilter[Filter.vegan]! && !meal.isVegan) {
        return false; // Donc je ne l'inclus pas 
      }

      return true; // Pour si les condition sont false on peut afficher les auttre repas
    }).toList();
  }
);