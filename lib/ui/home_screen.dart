import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:summitgear/ui/login.dart';
import 'package:summitgear/ui/main_screen.dart';

final _firestore = FirebaseFirestore.instance;

List<BottomNavigationBarItem> _bottomNavigationBar = const [
  BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
  BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
  BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
  BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
];

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2225,
              decoration: BoxDecoration(
                color: Color(0xFF94CABD),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/foto.png'),
                          radius: 25,
                        ),
                        SizedBox(width: 10), // Adding space between avatar and text
                        Text(
                          "Selamat Datang",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Set text color to white
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      labelText: "Cari",
                      prefixIcon: Icon(
                        Icons.search,
                        size: 24.0,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 20), // Adding space between search bar and card
                  SizedBox(
                    height: 200, // Set the height of the banner
                    child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true, // Set auto play to true
                        aspectRatio: 2.0, // Set the aspect ratio of the banner items
                        enlargeCenterPage: true, // Enlarge center item
                      ),
                      items: [
                        // Add your banner items here
                        Container(
                          width: 300, // Set the width of each banner item
                          margin: const EdgeInsets.only(right: 10), // Add margin between items
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.asset(
                              "assets/banner1.jpg",
                              width: 120.0,
                              height: 120.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          width: 300, // Set the width of each banner item
                          margin: const EdgeInsets.only(right: 10), // Add margin between items
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.asset(
                              "assets/banner2.jpg",
                              width: 120.0,
                              height: 120.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          width: 300, // Set the width of each banner item
                          margin: const EdgeInsets.only(right: 10), // Add margin between items
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.asset(
                              "assets/banner3.jpg",
                              width: 120.0,
                              height: 120.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Berita Terbaru',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Tambahkan kode yang ingin dijalankan ketika ikon ditekan
                          },
                          child: Icon(
                            Icons.arrow_right_alt_outlined,
                            size: 40.0,
                          ),
                        ),
                      ],
                    ),
                  ),
            SizedBox(height: 20), // Adding space between carousel and card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        'assets/banner1.jpg', // Replace with your image asset
                        height: 150.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Jalur Pendakian Gunung Slamet",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Tercatat ada 11 jalur pendakian Gunung Slamet. Ke-11 jalur pendakian itu yakni Jalur Bambangan di Kabupaten Purbalingga, Jalur Baturaden di Banyumas, Jalur Dhipajaya di Pemalang, Jalur Guci dan Jalur Dukuhliwung di Kabupaten Tegal, Jalur Kaliwadas dan Jalur Kaligua di Brebes.Selain tujuh jalur itu masih ada empat jalur lagi yang juga kerap digunakan pendakian, yakni Jalur Gunung Malang, Jalur Cemara Sakti, Jalur Penakir, serta Jalur Jurang Mangu.",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
