import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'favorites_screen.dart';

/// Main screen with bottom navigation (Home and Favorites) on all screen sizes.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final GlobalKey<FavoritesScreenState> _favoritesKey = GlobalKey();

  late final List<Widget> _screens = [
    const HomeScreen(),
    FavoritesScreen(key: _favoritesKey),
  ];

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
    if (index == 1 && _favoritesKey.currentState != null) {
      _favoritesKey.currentState!.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        selectedItemColor: Theme.of(context).colorScheme.onSurface,
        unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}
