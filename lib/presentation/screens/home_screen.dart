
import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../data/sample_data.dart';
import '../widgets/section_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final filteredItems = sampleItems.where((item) {
      if (selectedFilter == 'Pets') {
        return item.type == IconType.pet;
      }

      if (selectedFilter == 'Plants') {
        return item.type == IconType.plant;
      }

      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Care'),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search coming soon')),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // Filters
          Row(
            children: ['All', 'Pets', 'Plants'].map((filter) {
              final selected = selectedFilter == filter;

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(filter),
                  selected: selected,
                  onSelected: (_) {
                    setState(() {
                      selectedFilter = filter;
                    });
                  },
                  selectedColor: AppColors.primary,
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : AppColors.primary,
                  ),
                  side: const BorderSide(
                    color: AppColors.border,
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          // Due today
          const SectionTitle(
            title: 'Due today (2)',
            action: 'See all',
          ),

          const SizedBox(height: 10),

          ...sampleTasks.map((task) {
            return Card(
              child: CheckboxListTile(
                value: task.isDone,
                onChanged: (_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${task.title} tapped')),
                  );
                },
                title: Text(
                  task.title,
                  style: const TextStyle(fontSize: 13),
                ),
                secondary: Text(
                  task.time,
                  style: const TextStyle(fontSize: 11),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: AppColors.primary,
                dense: true,
              ),
            );
          }),

          const SizedBox(height: 20),

          // Pets and plants
          SectionTitle(
            title: 'My pets & plants (${filteredItems.length})',
          ),

          const SizedBox(height: 12),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredItems.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.95,
            ),
            itemBuilder: (context, index) {
              final item = filteredItems[index];

              return InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${item.name} selected')),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            item.type == IconType.pet
                                ? Icons.pets
                                : Icons.eco,
                            size: 45,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        item.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        item.description,
                        style: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 80),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add Pet / Plant coming soon')),
          );
        },
        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.secondaryText,
        onTap: (index) {
          if (index != 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('This section is being developed'),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'My Care',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Reminders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
