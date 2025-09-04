import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class FilesScreen extends ConsumerWidget {
  const FilesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FA),
        elevation: 0,
        leading: Row(
          children: [
            const SizedBox(width: 16),
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
        leadingWidth: 120,
        title: const Text(
          'Files',
          style: TextStyle(
            color: Color(0xFF1E2A51),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search files & folders...',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  prefixIcon: Icon(Iconsax.search_normal, color: Colors.grey.shade700),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
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
                    child: const Text('All Categories', style: TextStyle(color: Colors.white)),
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
                'Recent Files',
                style: TextStyle(
                  color: Color(0xFF1E2A51),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const _FileTile(
                icon: Iconsax.graph,
                fileName: 'Q3 Financial Report.pdf',
                tag: '.pdf',
                tagColor: Colors.red,
                trailing: '2h ago',
              ),
              const SizedBox(height: 12),
              const _FileTile(
                icon: Iconsax.document_text,
                fileName: 'Server Error Logs.txt',
                subtitle: 'Weekly Performance Summary.csv',
                trailingIcon: Iconsax.arrow_right_3,
              ),
              const SizedBox(height: 30),
              const Text(
                'Folders',
                style: TextStyle(
                  color: Color(0xFF1E2A51),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const _FolderTile(
                iconColor: Color(0xFF4A69FF),
                folderName: 'Project Mercury',
                trailingIcon: Iconsax.arrow_right_34,
              ),
              const SizedBox(height: 12),
              const _FolderTile(
                iconColor: Colors.grey,
                folderName: 'Archived Data',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FileTile extends StatelessWidget {
  const _FileTile({
    required this.icon,
    required this.fileName,
    this.subtitle,
    this.tag,
    this.tagColor,
    this.trailing,
    this.trailingIcon,
  });

  final IconData icon;
  final String fileName;
  final String? subtitle;
  final String? tag;
  final Color? tagColor;
  final String? trailing;
  final IconData? trailingIcon;

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
        title: Row(
          children: [
            Text(
              fileName.split('.')[0],
              style: const TextStyle(
                color: Color(0xFF1E2A51),
                fontWeight: FontWeight.bold,
              ),
            ),
            if (tag != null)
              Text(
                tag!,
                style: TextStyle(color: tagColor ?? Colors.grey, fontWeight: FontWeight.bold),
              ),
          ],
        ),
        subtitle: subtitle != null ? Text(subtitle!, style: const TextStyle(color: Colors.grey)) : null,
        trailing: trailingIcon != null
            ? Icon(trailingIcon, color: Colors.grey)
            : Text(trailing ?? '', style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}

class _FolderTile extends StatelessWidget {
  const _FolderTile({
    required this.iconColor,
    required this.folderName,
    this.trailingIcon,
  });

  final Color iconColor;
  final String folderName;
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(Iconsax.folder, color: iconColor, size: 40),
        title: Text(
          folderName,
          style: const TextStyle(
            color: Color(0xFF1E2A51),
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: trailingIcon != null ? Icon(trailingIcon, color: Colors.grey) : null,
      ),
    );
  }
}
