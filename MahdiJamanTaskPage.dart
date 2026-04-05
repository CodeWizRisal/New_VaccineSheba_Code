import 'package:flutter/material.dart';

class MahdiJamanTaskPage extends StatefulWidget {
  const MahdiJamanTaskPage({super.key});

  @override
  State<MahdiJamanTaskPage> createState() => _MahdiJamanTaskPageState();
}

class _MahdiJamanTaskPageState extends State<MahdiJamanTaskPage> {
  bool _isNotificationOn = true;

  final List<Map<String, String>> _vaccineData = [
    {
      "title": "Covid-19 (1st Dose)",
      "status": "Completed",
      "date": "10 Feb 2026",
    },
    {
      "title": "Covid-19 (2nd Dose)",
      "status": "Pending",
      "date": "TBA",
    },
    {
      "title": "Polio Vaccine",
      "status": "Scheduled",
      "date": "20 June 2026",
    },
  ];

  void _handleNotification(bool value) {
    setState(() {
      _isNotificationOn = value;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value ? '🔔 Notifications Enabled' : '🔕 Notifications Disabled',
        ),
        backgroundColor: value ? Colors.green : Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  double get progressValue {
    if (_vaccineData.isEmpty) return 0.0;
    int completed =
        _vaccineData.where((v) => v["status"] == "Completed").length;
    return completed / _vaccineData.length;
  }

  Map<String, String>? get nextVaccine {
    try {
      return _vaccineData.firstWhere((v) => v["status"] != "Completed");
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Tracker"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Receive Notification",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              child: SwitchListTile(
                value: _isNotificationOn,
                onChanged: _handleNotification,
                title: const Text("Enable Notifications"),
                subtitle: const Text("Get alerts for upcoming vaccines"),
                secondary: Icon(
                  _isNotificationOn
                      ? Icons.notifications_active
                      : Icons.notifications_off,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              "Vaccination Progress",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: progressValue,
                      minHeight: 10,
                      backgroundColor: Colors.grey,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${(progressValue * 100).toInt()}% Completed",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            if (nextVaccine != null) ...[
              const Text(
                "Next Vaccine",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Card(
                color: Colors.green.shade50,
                child: ListTile(
                  leading: const Icon(Icons.event, color: Colors.green),
                  title: Text(
                    nextVaccine!['title']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Date: ${nextVaccine!['date']}"),
                  trailing: const Text(
                    "Upcoming",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],
            const Text(
              "Track Vaccination",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _vaccineData.length,
              itemBuilder: (context, index) {
                final data = _vaccineData[index];
                final status = data['status'];

                Color color;
                IconData icon;

                if (status == "Completed") {
                  color = Colors.green;
                  icon = Icons.check_circle;
                } else if (status == "Pending") {
                  color = Colors.orange;
                  icon = Icons.pending;
                } else {
                  color = Colors.blue;
                  icon = Icons.schedule;
                }

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Icon(icon, color: color),
                    title: Text(
                      data['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Date: ${data['date']}"),
                    trailing: Text(
                      status!,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}