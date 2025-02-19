// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/ui/Profile_Details/profile_details_screen.dart';
import 'package:online_exam_app/ui/Profile_Details/viewmodel/profile_details_cubit.dart';
import 'package:online_exam_app/Shared/widgets/custom_bottom_navigation_bar.dart';
import 'package:online_exam_app/ui/explorescreen/explore_screen.dart';
import 'package:online_exam_app/ui/resultscreen/result_screen.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ExploreScreen(), // Replace with your actual screen widget
    ResultScreen(),
    BlocProvider(
      create: (context) => GetIt.I<ProfileDetailsCubit>(),
      child: const ProfileDetailsScreen(),
    ),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onTabChange: _onTabSelected,
      ),
    );
  }
}
