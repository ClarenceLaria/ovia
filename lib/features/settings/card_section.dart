import 'package:flutter/material.dart';

class CardSection extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const CardSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: List.generate(data.length, (index) {
          final item = data[index];
          final isLast = index == data.length - 1;
          return _CardListTile(
            icon: item['icon'] as IconData,
            title: item['title'] as String,
            isLast: isLast,
          );
        }),
      ),
    );
  }
}

class _CardListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isLast;

  const _CardListTile({
    required this.icon,
    required this.title,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black, size: 22),
          title: Text(title, style: const TextStyle(fontSize: 14)),
          trailing: const Icon(Icons.chevron_right_outlined, size: 20),
          horizontalTitleGap: 8,
          dense: true,
          visualDensity: VisualDensity.compact,
        ),
        if (!isLast)
          const Divider(height: 0.5, thickness: 0.5, indent: 16, endIndent: 16),
      ],
    );
  }
}
