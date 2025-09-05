import 'package:flutter/material.dart';

class FilterPopupMenu extends StatelessWidget {
  const FilterPopupMenu({required this.onOptionTapped, super.key});

  final Function(FilterOptions) onOptionTapped;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<FilterOptions>(
      icon: Icon(Icons.sort_sharp),
      onSelected: (FilterOptions option) {
        onOptionTapped(option);
      },
      itemBuilder: (context) => <PopupMenuEntry<FilterOptions>>[
        PopupMenuItem<FilterOptions>(
          value: FilterOptions.byDate,
          child: Text(FilterOptions.byDate.name),
        ),
        PopupMenuItem<FilterOptions>(
          value: FilterOptions.byTitle,
          child: Text(FilterOptions.byTitle.name),
        ),
      ],
    );
  }
}

enum FilterOptions { byDate, byTitle }
