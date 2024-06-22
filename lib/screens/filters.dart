import 'package:flutter/material.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class FilterScreen extends ConsumerWidget {
  const FilterScreen({
    super.key,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vos Filtres'),
      ),

      body:/* PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if(didPop) return;
          
          ref.read(filtersProvider.notifier).setFilters({
            Filter.glutenfree: _glutenfreeFilterSet ,
            Filter.lactosefree: _lactosefreeFilterSet,
            Filter.vegetarian: _vegetarianFilterSet ,
            Filter.vegan: _vegenFilterSet,
          });

          Navigator.of(context).pop();
        },
        child: */Column(
          children: [
        
            SwitchListTile(
              value: activeFilters[Filter.glutenfree]!,
              onChanged: (isChecked){
                ref.read(filtersProvider.notifier).setFilter(Filter.glutenfree, isChecked);
              },
              title: Text(
                'Sans gluten',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              subtitle: Text(
                'Ne contient que des plats sans gluten',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 32, right: 22),
            ),
        
            SwitchListTile(
              value: activeFilters[Filter.lactosefree]!,
              onChanged: (isChecked){
                ref.read(filtersProvider.notifier).setFilter(Filter.lactosefree, isChecked);
              },
              title: Text(
                'Sans Lactose',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              subtitle: Text(
                'Ne contient que des plats sans Lactose',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 32, right: 22),
            ),
        
            SwitchListTile(
              value: activeFilters[Filter.vegetarian]!,
              onChanged: (isChecked){
                ref.read(filtersProvider.notifier).setFilter(Filter.vegetarian, isChecked);
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              subtitle: Text(
                'Ne contient que des plats pour vegetarian',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 32, right: 22),
            ),
        
            SwitchListTile(
              value: activeFilters[Filter.vegan]!,
              onChanged: (isChecked){
                ref.read(filtersProvider.notifier).setFilter(Filter.vegan, isChecked);
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              subtitle: Text(
                'Ne contient que des plats pour vegan',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 32, right: 22),
            ),
        
          ],
        ),
      )/*,
    )*/;
  }
}