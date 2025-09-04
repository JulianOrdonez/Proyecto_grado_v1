import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FA),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Vize',
              style: TextStyle(
                color: Color(0xFF1E2A51),
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Iconsax.eye,
              color: Colors.blue.shade800,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.notification, color: Color(0xFF1E2A51)),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search',
              style: TextStyle(
                color: Color(0xFF1E2A51),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for data, devices',
                hintStyle: TextStyle(color: Colors.grey.shade500),
                prefixIcon: Icon(Iconsax.search_normal, color: Colors.grey.shade700),
                suffixIcon: Icon(Iconsax.microphone, color: Colors.grey.shade700),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A69FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text('All categories', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () {},
                   style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                     shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text('Reports', style: TextStyle(color: Color(0xFF1E2A51))),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Recent searches',
              style: TextStyle(
                color: Color(0xFF1E2A51),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const _RecentSearchTile(
              icon: Iconsax.graph,
              title: 'Proyector',
              subtitle: 'Encendido-Apagado',
            ),
            const SizedBox(height: 12),
            const _RecentSearchTile(
              icon: Iconsax.user,
              title: 'Proyector',
              subtitle: 'Encendido-Apagado',
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentSearchTile extends StatelessWidget {
  const _RecentSearchTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade100,
          child: Icon(icon, color: const Color(0xFF1E2A51)),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF1E2A51),
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
