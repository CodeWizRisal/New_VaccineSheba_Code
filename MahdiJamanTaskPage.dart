import 'package:flutter/material.dart';

class MahdiJamanTaskPage extends StatelessWidget {
  const MahdiJamanTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> vaccineData = [
      {"title": "Covid-19 (1st Dose)", "status": "Completed", "date": "10 Feb 2026"},
      {"title": "Covid-19 (2nd Dose)", "status": "Pending", "date": "TBA"},
      {"title": "Polio Vaccine", "status": "Scheduled", "date": "20 June 2026"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Tracker"), backgroundColor: Colors.green),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: vaccineData.length,
        itemBuilder: (context, index) {
          final data = vaccineData[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.vaccines, color: Colors.green),
              title: Text(data['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("Date: ${data['date']}"),
              trailing: Text(data['status']!, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            ),
          );
        },
      ),
    );
  }
}
