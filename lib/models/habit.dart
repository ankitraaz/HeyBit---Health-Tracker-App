import 'package:flutter/material.dart';

class Habit {
  final String title;
  final String subtitle;
  final IconData icon;
  bool completed;

  Habit({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.completed = false,
  });
}
