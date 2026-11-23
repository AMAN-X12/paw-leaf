
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monty'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => context.push('/items/1/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('More options coming soon')),
              );
            },
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // Hero photo
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: AppColors.lightSurface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: const Center(
              child: Icon(Icons.pets, size: 65, color: Colors.grey),
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Monty',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 5),

          const Text(
            'Dog - Labrador',
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 5),

          const Text(
            '3 years | With you since Mar 2023',
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 20),

          // Quick actions
          Row(
            children: [
              Expanded(
                child: _actionButton(
                  context,
                  Icons.check_circle_outline,
                  'Log care',
                  () => context.push('/items/1/log'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _actionButton(
                  context,
                  Icons.notifications_none,
                  'Reminder',
                  () => context.push('/reminders/new'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _actionButton(
                  context,
                  Icons.camera_alt_outlined,
                  'Photo',
                  () => context.push('/items/1/photos'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          const Text(
            'Next reminders',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          _reminderCard(Icons.restaurant, 'Feed - Monty', 'Daily 8:00'),
          _reminderCard(Icons.medical_services_outlined, 'Vet visit', '12 Dec'),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent care',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => context.push('/items/1/log'),
                child: const Text('Care log >'),
              ),
            ],
          ),

          _careRow('Fed', 'Today 8:02'),
          _careRow('Walk note', 'Yesterday 17:40'),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Photos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => context.push('/items/1/photos'),
                child: const Text('Timeline >'),
              ),
            ],
          ),

          Row(
            children: List.generate(
              4,
              (index) => Expanded(
                child: Container(
                  height: 65,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    color: AppColors.lightSurface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Icon(Icons.image_outlined, color: Colors.grey),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: ListTile(
              leading: const Icon(Icons.eco_outlined),
              title: const Text('Care tips for Labrador'),
              subtitle: const Text('General information, not vet advice'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Care tips coming soon')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, size: 22),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _reminderCard(IconData icon, String title, String time) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Text(time, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }

  Widget _careRow(String title, String time) {
    return ListTile(
      dense: true,
      leading: const Icon(Icons.circle, size: 9),
      title: Text(title),
      trailing: Text(time, style: const TextStyle(color: Colors.grey)),
    );
  }
}
