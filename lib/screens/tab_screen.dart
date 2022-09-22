import 'package:flutter/material.dart';
import '/screens/search_item_screen.dart';

import 'category_screen.dart';
import 'favorite_screen.dart';
import '/widgets/main_drawer.dart';

class Tabs extends StatefulWidget {
  List favMeal;

  Tabs(this.favMeal);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  late List<Map<String, dynamic>> _pages;

  @override
  void initState() {
    _pages = [
      {'pages': const Category(), 'title': 'Category'},
      {'pages': Favorite(widget.favMeal), 'title': 'Your Favorite'},
    ];

    super.initState();
  }

  int _selectPageIndex = 0;

  void _selectPage(index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectPageIndex]['title']),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchBar());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      drawer: const MainDrawer(),
      body: _pages[_selectPageIndex]['pages'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.white,
        currentIndex: _selectPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}

class SearchBar extends SearchDelegate<String> {
  Map<String, Object> categorySearch = {
    'Italian': 'c1',
    'Quick & Easy': 'c2',
    'Hamburgers': 'c3',
    'German': 'c3',
    'Light & Lovely': 'c5',
    'Exotic': 'c6',
    'Breakfast': 'c7',
    'Asian': 'c8',
    'French': 'c9',
    'Summer': 'c10',
  };

  Map<String, Object> recentSearch = {
    'c3': 'Hamburgers',
    'c4': 'German',
    'c5': 'Light & Lovely',
    'c6': 'Exotic',
  };

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List suggestionlist = query.isEmpty
        ? recentSearch.keys.toList()
        : categorySearch.keys
            .where((element) => element.startsWith(query))
            .toList();

    return ListView.builder(
      itemCount: query.isEmpty ? 0 : suggestionlist.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(
              SearchItemList.routeName,
              arguments: [categorySearch[suggestionlist[0]], suggestionlist[0]],
            );
          },
          leading: const Icon(Icons.food_bank),
          title: RichText(
            text: TextSpan(
                text: suggestionlist[index].substring(0, query.length),
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: suggestionlist[index].substring(query.length),
                      style: const TextStyle(color: Colors.grey))
                ]),
          ),
        );
      },
    );
  }
}
