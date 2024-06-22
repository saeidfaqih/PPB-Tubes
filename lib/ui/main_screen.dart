import 'package:summitgear/ui/home_screen.dart';
import 'package:summitgear/ui/registration.dart';
import 'package:summitgear/ui/message.dart';
import 'package:summitgear/ui/profile.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bottom_nav/bottom_nav_bloc.dart';

List<Widget> _bodyItems = [
  HomeScreen(),
  FavoriteScreen(),
  MessageScreen(),
  ProfileScreen(),
];

List<BottomNavigationBarItem> _bottomNavigationBar = const [
  BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
  BottomNavigationBarItem(icon: Icon(Icons.app_registration), label: "Registration"),
  BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
  BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
];

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return Scaffold(
          body: _bodyItems[state.tabIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: _bottomNavigationBar,
            currentIndex: state.tabIndex,
            selectedItemColor: const Color(0xFF58A975),
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              // Tentukan rute yang sesuai untuk setiap tab
              String routeName;
              switch (index) {
                case 0:
                  routeName = '/home';
                  break;
                case 1:
                  routeName = '/favorite';
                  break;
                case 2:
                  routeName = '/message';
                  break;
                case 3:
                  routeName = '/profile';
                  break;
                default:
                  routeName = '/home'; // Default jika indeks tidak sesuai
              }
              // Navigasi ke rute yang sesuai ketika tab diklik
              Navigator.pushNamed(context, routeName);
            },
          ),
        );
      },
    );
  }
}

