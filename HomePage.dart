import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp_test/LoginPage.dart';
import 'package:newapp_test/MahdiJamanTaskPage.dart';
import 'package:newapp_test/FindPage.dart';
import 'package:newapp_test/AppointmentPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("VaccineSheba"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: index == 0
          ? homeUI()
          : index == 1
          ? profileUI()
          : const MahdiJamanTaskPage(),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.green,
        onTap: (i) {
          setState(() {
            index = i;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.track_changes), label: "Tracker"),
        ],
      ),
    );
  }

  // ================= HOME =================
  Widget homeUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          // 🔍 FIND VACCINE
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FindPage()),
              );
            },
            child: const Text("Find Vaccine"),
          ),

          const SizedBox(height: 20),

          // 🔥 BOOK APPOINTMENT
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppointmentPage(),
                ),
              );
            },
            child: const Text("Book Appointment"),
          ),
        ],
      ),
    );
  }

  // ================= PROFILE =================
  Widget profileUI() {
    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(user?.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text("User details not found"));
        }

        var userData = snapshot.data!.data() as Map<String, dynamic>;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.green,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),

              const SizedBox(height: 15),

              Text(
                userData['name'] ?? "No Name",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                userData['email'] ?? "No Email",
                style: const TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 25),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 3,
                child: Column(
                  children: [

                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.cake, color: Colors.green),
                      title: const Text("Age"),
                      trailing: Text(userData['age'] ?? "Not set"),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.person_outline, color: Colors.green),
                      title: const Text("Gender"),
                      trailing: Text(userData['gender'] ?? "Not set"),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.bloodtype, color: Colors.green),
                      title: const Text("Blood Group"),
                      trailing: Text(userData['bloodGroup'] ?? "Not set"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    if (mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                            (route) => false,
                      );
                    }
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
