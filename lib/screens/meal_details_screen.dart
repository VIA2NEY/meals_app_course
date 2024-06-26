import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final favoriteMeals = ref.watch(favoriteMealsProvider);

    bool isFavorite =favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: (){
              final wasAdded = ref.read(
                  favoriteMealsProvider.notifier
                ).toggleMealFavoriteStatus(meal);
              
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded ? "Le repas est ajouté aux favoris" : "Le repas n'est plus favoris")
                )
              );

            }, 
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavorite),
              ),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(
                    begin: 0.5,
                    end: 1
                  ).animate(animation), 
                  child: child
                );
              },
            )
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              width: double.infinity,
              height: 300,
            ),
            const SizedBox(height: 14,),
            Text(
              "Ingredients",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold
              ),
            ),
        
            const SizedBox(height: 14,),
        
            for (final ingredient in meal.ingredients) 
              Text(
                ingredient,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground
                ),
              ),
        
            const SizedBox(height: 14),
            Text(
              "Etapes",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold
              ),
            ),
        
            const SizedBox(height: 14),
        
            for (final step in meal.steps) 
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                  ),
                ),
              ),
        
          ],
        ),
      ),
    );
  }
}