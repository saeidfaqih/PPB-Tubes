import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:summitgear/ui/login.dart';
import 'package:summitgear/repositories/auth_repo.dart'; // Pastikan Anda mengimpor kelas AuthRepo

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? _user;
  final AuthRepo _authRepo = AuthRepo();

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  void _logout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Apakah Anda yakin ingin keluar?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Batal',
                style: TextStyle(
                  color: Color(0xFF58A975),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                      (route) => false,
                );
              },
              child: const Text(
                'Keluar',
                style: TextStyle(
                  color: Color(0xFF58A975),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String _getUsernameFromEmail(String email) {
    return email.split('@')[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF94CABD),
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xffffffff)),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _logout(context);
            },
            icon: const Icon(
              Icons.logout,
              size: 26.0,
            ),
          ),
        ],
        toolbarHeight: 70,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/foto.png'),
                    radius: 70,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _user != null
                ? FutureBuilder<Map<String, dynamic>?>(
                future: _authRepo.getUserData(_user!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    print('Error: ${snapshot.error}');
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData && snapshot.data != null) {
                    String email = snapshot.data!['email'] ?? "Email Tidak Ditemukan";
                    String username = _getUsernameFromEmail(email);
                    return Column(
                      children: [
                        Text(
                          username,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          email,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    );
                  } else {
                    print('Data tidak tersedia');
                    return const Text('Data tidak tersedia');
                  }
                })
                : const Text('Anda belum masuk'),
          ],
        ),
      ),
    );
  }
}
