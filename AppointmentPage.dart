import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Vaccine Sheba",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Track Vaccination
            const Text(
              "Track Vaccination",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 10),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: const Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.check_circle,
                        color: Colors.green),
                    title: Text("Covid-19 (1st Dose)"),
                    subtitle: Text("Status: Completed"),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.pending,
                        color: Colors.orange),
                    title: Text("Covid-19 (2nd Dose)"),
                    subtitle: Text("Status: Pending"),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.calendar_today,
                        color: Colors.blue),
                    title: Text("Polio Vaccine"),
                    subtitle: Text("Scheduled: 20 June 2026"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// Doctor Booking
            const Text(
              "Book Doctor Appointment",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 10),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('doctors')
                  .snapshots(),
              builder: (context, snapshot) {

                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator());
                }

                if (!snapshot.hasData ||
                    snapshot.data!.docs.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                          "No doctors available in Database."),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {

                    final data =
                        snapshot.data!.docs[index].data()
                            as Map<String, dynamic>? ??
                            {};

                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12)),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(Icons.person,
                              color: Colors.white),
                        ),
                        title: Text(
                          data['name'] ?? 'Unknown Doctor',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle:
                            Text(data['specialist'] ?? ''),
                        trailing: ElevatedButton(
                          onPressed: () async {
                            final user = FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              try {
                                await FirebaseFirestore.instance
                                    .collection('appointments')
                                    .add({
                                  'userId': user.uid,
                                  'doctorId': snapshot.data!.docs[index].id,
                                  'doctorName': data['name'],
                                  'status': 'pending',
                                  'bookingDate': FieldValue.serverTimestamp(),
                                });

                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Appointment request sent to ${data['name']}",
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Error: $e"),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please login to book"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor:
                                Colors.white,
                          ),
                          child: const Text("Book"),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
