import 'package:flutter/material.dart';
import 'package:login_template/home/screens/cart_selected_screen.dart';
import 'package:login_template/home/screens/chat_selected_screen.dart';
import 'package:login_template/home/screens/home_selected_screen.dart';
import 'package:login_template/home/screens/notification_selected_screen.dart';
import 'package:login_template/home/screens/profile_selected_screen.dart';
import 'package:login_template/home/screens/search_selected_screen.dart';
import 'package:login_template/l10n/app_localizations.dart';
import 'package:login_template/settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeSelectedScreen(),
    const SearchSelectedScreen(),
    const CartSelectedScreen(),
    const ProfileSelectedScreen(),
    const NotificationsSelectedScreen(),
    const ChatSelectedScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  final _selectedIconSize = 29.0;
  final _unSelectedIconSize = 26.0;

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final selectedIconColor = Theme.of(context).colorScheme.tertiary;
    final unSelectedIconColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          tr.brand,
          style: TextStyle(
            color: unSelectedIconColor,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
            icon: Icon(Icons.settings, color: unSelectedIconColor),
          ),
        ],
      ),

      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
        children: _widgetOptions,
      ),

      floatingActionButton: FloatingActionButton(onPressed: () async {}),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: unSelectedIconColor, width: 2)),
        ),
        child: NavigationBar(
          indicatorColor: unSelectedIconColor,
          backgroundColor: Theme.of(context).colorScheme.primary,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          animationDuration: const Duration(milliseconds: 500),

          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,

          destinations: <Widget>[
            NavigationDestination(
              selectedIcon: Icon(
                Icons.home,
                color: selectedIconColor,
                size: _selectedIconSize,
              ),
              icon: Icon(
                Icons.home_outlined,
                color: unSelectedIconColor,
                size: _unSelectedIconSize,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.search,
                color: selectedIconColor,
                size: _selectedIconSize,
              ),
              icon: Icon(
                Icons.search_outlined,
                color: unSelectedIconColor,
                size: _unSelectedIconSize,
              ),
              label: 'Search',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.shopping_cart,
                color: selectedIconColor,
                size: _selectedIconSize,
              ),
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: unSelectedIconColor,
                size: _unSelectedIconSize,
              ),
              label: 'Cart',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.person,
                color: selectedIconColor,
                size: _selectedIconSize,
              ),
              icon: Icon(
                Icons.person_outline,
                color: unSelectedIconColor,
                size: _unSelectedIconSize,
              ),
              label: 'Profile',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.notifications,
                color: selectedIconColor,
                size: _selectedIconSize,
              ),
              icon: Icon(
                Icons.notifications_outlined,
                color: unSelectedIconColor,
                size: _unSelectedIconSize,
              ),
              label: 'Notifications',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.chat,
                color: selectedIconColor,
                size: _selectedIconSize,
              ),
              icon: Icon(
                Icons.chat_outlined,
                color: unSelectedIconColor,
                size: _unSelectedIconSize,
              ),
              label: 'Chat',
            ),
          ],
        ),
      ),
    );
  }
}
