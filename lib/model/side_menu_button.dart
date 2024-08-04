import 'package:flutter/material.dart';

class SideMenuButton {
  final String tittle;
  final IconData icon;

  SideMenuButton({required this.tittle, required this.icon});
}

final List<SideMenuButton> sideMenuButton = [
  SideMenuButton(tittle: 'Dashboad', icon: Icons.home),
  SideMenuButton(tittle: 'Oder Bill', icon: Icons.inventory_outlined),
  SideMenuButton(
      tittle: 'Manage Dishes', icon: Icons.dashboard_customize_rounded),
  SideMenuButton(tittle: 'Oder History', icon: Icons.history),
];
