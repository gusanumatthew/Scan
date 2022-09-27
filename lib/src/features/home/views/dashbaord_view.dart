import 'package:alome/src/core/constants/colors.dart';
import 'package:alome/src/features/authentication/models/app_user.dart';
import 'package:alome/src/features/home/views/cards.dart';
import 'package:alome/src/features/home/views/home.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  final AppUser user;
  const DashboardView({Key? key, required this.user}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0;
  void _onPageChanged(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: [
        HomeView(
          user: widget.user,
        ),
        const CardsView(),
      ].elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.lightBlue,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.credit_card_rounded), label: "Cards"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onPageChanged,
      ),
      // ),
    );
  }
}
