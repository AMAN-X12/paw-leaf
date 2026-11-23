
class CareTask {
  final String title;
  final String time;
  final bool isDone;

  const CareTask({
    required this.title,
    required this.time,
    this.isDone = false,
  });
}

class CareItem {
  final String name;
  final String description;
  final IconType type;

  const CareItem({
    required this.name,
    required this.description,
    required this.type,
  });
}

enum IconType { pet, plant }

const List<CareTask> sampleTasks = [
  CareTask(title: 'Water Monstera', time: '9:00'),
  CareTask(title: 'Feed Monty', time: '8:00', isDone: true),
];

const List<CareItem> sampleItems = [
  CareItem(
    name: 'Monty',
    description: 'Next: Feed, 8:00',
    type: IconType.pet,
  ),
  CareItem(
    name: 'Monstera',
    description: 'Next: Water, 2d',
    type: IconType.plant,
  ),
  CareItem(
    name: 'Fern',
    description: 'Overdue: Water',
    type: IconType.plant,
  ),
  CareItem(
    name: 'Luna',
    description: 'Vet visit, 12 Dec',
    type: IconType.pet,
  ),
];
