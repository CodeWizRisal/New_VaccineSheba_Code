import 'package:flutter/material.dart';

class FindPage extends StatelessWidget {
  const FindPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text("Find Vaccines"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Available Vaccines",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 12),
            vaccineCard(
              context,
              title: "COVID-19 Vaccine",
              place: "Dhaka Medical College",
              date: "Available: 5 March 2026",
            ),
            const SizedBox(height: 10),
            vaccineCard(
              context,
              title: "Hepatitis B Vaccine",
              place: "Square Hospital",
              date: "Available: 10 March 2026",
            ),
            const SizedBox(height: 10),
            vaccineCard(
              context,
              title: "Flu Vaccine",
              place: "Popular Diagnostic",
              date: "Available: 15 March 2026",
            ),
          ],
        ),
      ),
    );
  }

  Widget vaccineCard(BuildContext context,
      {required String title, required String place, required String date}) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(place),
                Text(date, style: const TextStyle(color: Colors.green)),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingPage(
                    title: title,
                    place: place,
                    date: date,
                  ),
                ),
              );
            },
            child: const Text("Book"),
          ),
        ],
      ),
    );
  }
}

//BOOKING PAGE
class BookingPage extends StatelessWidget {
  final String title;
  final String place;
  final String date;

  const BookingPage({super.key, required this.title, required this.place, required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Vaccine"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Vaccine: $title", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Place: $place", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text(date, style: const TextStyle(fontSize: 16, color: Colors.green)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Booking Confirmed ✅")),
                  );
                },
                child: const Text("Confirm Booking", style: TextStyle(fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
