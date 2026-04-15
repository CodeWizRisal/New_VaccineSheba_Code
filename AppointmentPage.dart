import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Doctors"),
          foregroundColor: Colors.white,
          backgroundColor: Colors.green),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          _doctorCard(context, "Dr. Mahdi Jaman", "Vaccine Specialist", "MBBS, MD"),
          _doctorCard(context, "Dr. Sarah Ahmed", "Immunology Expert", "MBBS, PhD"),
          _doctorCard(context, "Dr. Rezwan Kabir", "Public Health", "MBBS, MPH"),
        ],
      ),
    );
  }

  Widget _doctorCard(BuildContext context, String name, String spec, String qual) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.person, color: Colors.green, size: 40),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("$spec\n$qual"),
        trailing: ElevatedButton(
          onPressed: () {
            FirebaseFirestore.instance.collection('appointments').add({
              'doctor': name,
              'user': FirebaseAuth.instance.currentUser?.email,
              'time': DateTime.now()
            });
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Requested")));
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: const Text("Book", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
