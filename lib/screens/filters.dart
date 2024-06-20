import 'package:flutter/material.dart';
// import 'package:meals_app/screens/tabs.dart';
// import 'package:meals_app/widgets/main_drawer.dart';


enum Filter {
  glutenfree,
  lactosefree,
  vegetarian,
  vegen
}


class FilterScreen extends StatefulWidget {
  const FilterScreen({
    super.key,
    required this.currentFilters
  });

  final Map<Filter, bool> currentFilters;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  var _glutenfreeFilterSet = false;
  var _lactosefreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _vegenFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutenfreeFilterSet = widget.currentFilters[Filter.glutenfree]!;
    _lactosefreeFilterSet = widget.currentFilters[Filter.lactosefree]!;
    _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
    _vegenFilterSet = widget.currentFilters[Filter.vegen]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vos Filtres'),
      ),

      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'meals') {
      //       Navigator.of(context).push(
      //         MaterialPageRoute(builder: (ctx){
      //           return const TabsScreen();
      //         })
      //       );
      //     }
      //   },
      // ),

      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if(didPop) return;
          Navigator.of(context).pop({
            Filter.glutenfree: _glutenfreeFilterSet ,
            Filter.lactosefree: _lactosefreeFilterSet,
            Filter.vegetarian: _vegetarianFilterSet ,
            Filter.vegen: _vegenFilterSet,
          });
        },
        child: Column(
          children: [
        
            SwitchListTile(
              value: _glutenfreeFilterSet, 
              onChanged: (isChecked){
                setState(() {
                  _glutenfreeFilterSet = isChecked;
                });
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
              value: _lactosefreeFilterSet, 
              onChanged: (isChecked){
                setState(() {
                  _lactosefreeFilterSet = isChecked;
                });
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
              value: _vegetarianFilterSet, 
              onChanged: (isChecked){
                setState(() {
                  _vegetarianFilterSet = isChecked;
                });
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
              value: _vegenFilterSet, 
              onChanged: (isChecked){
                setState(() {
                  _vegenFilterSet = isChecked;
                });
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
      ),
    );
  }
}