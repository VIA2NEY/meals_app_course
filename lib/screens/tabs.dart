import 'package:flutter/material.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


const kInitialFilters = {
  Filter.glutenfree: false ,
  Filter.lactosefree: false,
  Filter.vegetarian: false ,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {

  int _selectedPageIndex = 0;


  void _selectPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });
    
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx){
          return const FilterScreen();
        })
      );

    }
  }

  @override
  Widget build(BuildContext context) {

    final meals = ref.watch(mealsprovider);

    final activefilter = ref.watch(filtersProvider);

    final availableMeals = meals.where((meal) {

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

    Widget activePage = CategoriesScreen(
      // onToggleFavorite: _toogleMealFavoriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {

      final favoriteMeals = ref.watch(favoriteMealsProvider);

      activePage = MealsScreen(
        meals: favoriteMeals, 
        // onToggleFavorite: _toogleMealFavoriteStatus,
      );
      activePageTitle = 'Your Favorites';
    } else {
      
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          activePageTitle
        ),
      ),

      drawer: MainDrawer(onSelectScreen: _setScreen,),

      body: activePage,

      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites'
          )
        ],
      ),
    );
  }
}