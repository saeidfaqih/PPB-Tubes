import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:summitgear/bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:summitgear/bloc/login/login_cubit.dart';
import 'package:summitgear/bloc/register/register_cubit.dart';
import 'package:summitgear/ui/home_screen.dart';
import 'package:summitgear/ui/login.dart';
import 'package:summitgear/ui/splash.dart';
import 'package:summitgear/ui/registration.dart';
import 'package:summitgear/ui/message.dart';
import 'package:summitgear/ui/profile.dart';
import 'package:summitgear/utils/routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => BottomNavBloc()),
      ],
      child: MaterialApp(
        title: "SummitG",
        debugShowCheckedModeBanner: false,
        navigatorKey: NAV_KEY,
        onGenerateRoute: generateRoute,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return MainScreen(); // Navigasi ke MainScreen jika pengguna sudah login
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            } else {
              return const LoginScreen();
            }
          },
        ),
        routes: {
          '/Home': (context) => MainScreen(),
          '/Favorite': (context) => FavoriteScreen(),
          '/Message': (context) => MessageScreen(),
          '/Profile': (context) => ProfileScreen(),
        },
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.tabIndex,
            children: [
              HomeScreen(),
              FavoriteScreen(),
              MessageScreen(),
              ProfileScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.app_registration), label: "Registration"),
              BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
            ],
            currentIndex: state.tabIndex,
            selectedItemColor: const Color(0xFF58A975),
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              BlocProvider.of<BottomNavBloc>(context).add(ChangeTabEvent(index));
            },
          ),
        );
      },
    );
  }
}
