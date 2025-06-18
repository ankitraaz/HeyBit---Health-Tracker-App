// ✅ UI preserved. Logic added for tracking completed habits by date.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widget/habit_card_widget.dart';

class Habit {
  final String title;
  final String subtitle;
  final IconData icon;

  Habit({required this.title, required this.subtitle, required this.icon});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Habit> habits = [
    Habit(
      title: "Bicycle",
      subtitle: "07:00 for 10km",
      icon: Icons.directions_bike,
    ),
    Habit(
      title: "Running",
      subtitle: "12:00 for 5km",
      icon: Icons.directions_run,
    ),
    Habit(title: "Workout", subtitle: "18:00 Gym", icon: Icons.fitness_center),
    Habit(title: "Reading", subtitle: "20:00 Book", icon: Icons.menu_book),
  ];

  // Stores completion per date (yyyy-MM-dd) -> habit index -> status
  Map<String, Set<int>> completedHabits = {};

  String get todayKey => DateFormat('yyyy-MM-dd').format(DateTime.now());

  void toggleHabitCompletion(int index) {
    final key = todayKey;
    setState(() {
      completedHabits.putIfAbsent(key, () => {});
      if (completedHabits[key]!.contains(index)) {
        completedHabits[key]!.remove(index);
      } else {
        completedHabits[key]!.add(index);
      }
    });
  }

  bool isHabitCompleted(int index) {
    final key = todayKey;
    return completedHabits[key]?.contains(index) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.grid_view_rounded),
                  Text("Wednesday, 24", style: TextStyle(fontSize: 16)),
                  Icon(Icons.settings_outlined),
                ],
              ),
            ),

            // Weekday selector
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: 5,
                itemBuilder: (context, index) {
                  final days = [
                    "Tue\n06",
                    "Wed\n07",
                    "Thu\n08",
                    "Fri\n09",
                    "Sat\n10",
                  ];
                  final isToday = index == 0;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Container(
                      width: 50,
                      decoration: BoxDecoration(
                        color: isToday ? Colors.red : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Center(
                        child: Text(
                          days[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isToday ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tuesday habit",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text("See all", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            // Habit cards
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final habit = habits[index];
                  final isCompleted = isHabitCompleted(index);
                  return GestureDetector(
                    onTap: () => toggleHabitCompletion(index),
                    child: HabitCard(
                      title: habit.title,
                      subtitle: habit.subtitle,
                      icon: habit.icon,
                      isCompleted: isCompleted,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}
