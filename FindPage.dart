import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FindPage extends StatelessWidget {
  const FindPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Find Vaccines"),foregroundColor: Colors.white,
          backgroundColor: Colors.green),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          _vaccineCard(context, "COVID-19", "DMCH", "Available: 5 March"),
          _vaccineCard(context, "Hepatitis B", "Square", "Available: 10 March"),
          _vaccineCard(context, "Flu Vaccine", "Popular", "Available: 15 March"),
        ],
      ),
    );
  }

  Widget _vaccineCard(BuildContext context, String title, String place, String date) {
    return Card(
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("$place\n$date"),
        trailing: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => ConfirmPage(title, place, date)));
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: const Text("Book", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

class ConfirmPage extends StatelessWidget {
  final String title, place, date;
  const ConfirmPage(this.title, this.place, this.date, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Confirm Booking"), backgroundColor: Colors.green),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Vaccine: $title", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text("Hospital: $place", style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text(date, style: const TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 40),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance.collection('bookings').add({
                      'title': title, 'place': place, 'date': date, 'time': DateTime.now()
                    });
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Confirmed")));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: const RoundedRectangleBorder(),
                  ),
                  child: const Text("Confirm", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
