import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/home_screen.dart';
import 'package:myapp/navigation.dart';
import 'package:myapp/screens/files_screen.dart';
import 'package:myapp/screens/search_screen.dart';
import 'package:myapp/widgets/custom_bottom_navigation_bar.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  final screens = const [HomeScreen(), SearchScreen(), FilesScreen()];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationProvider);

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: selectedIndex,
        onItemTapped: (index) {
          ref.read(navigationProvider.notifier).setIndex(index);
        },
      ),
    );
  }
}
