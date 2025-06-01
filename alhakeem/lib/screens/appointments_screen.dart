import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentsScreen extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text('حجز مواعيد العيادات')),

      body: FutureBuilder(

        future: FirebaseFirestore.instance.collection('clinics').get(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {

            return Center(child: CircularProgressIndicator());

          }

          final clinics = snapshot.data!.docs;

          return ListView.builder(

            itemCount: clinics.length,

            itemBuilder: (context, index) {

              final clinic = clinics[index];

              return ListTile(

                title: Text(clinic['name']),

                subtitle: Text('موقع: ${clinic['location']}'),

                trailing: ElevatedButton(

                  onPressed: () {

                    // عرض الأقسام والأطباء

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) => ClinicDetailsScreen(clinicId: clinic.id),

                      ),

                    );

                  },

                  child: Text('حجز موعد'),

                ),

              );

            },

          );

        },

      ),

    );

  }

}

class ClinicDetailsScreen extends StatelessWidget {

  final String clinicId;

  ClinicDetailsScreen({required this.clinicId});

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text('أطباء العيادة')),

      body: FutureBuilder(

        future: FirebaseFirestore.instance

            .collection('clinics')

            .doc(clinicId)

            .collection('doctors')

            .get(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {

            return Center(child: CircularProgressIndicator());

          }

          final doctors = snapshot.data!.docs;

          return ListView.builder(

            itemCount: doctors.length,

            itemBuilder: (context, index) {

              final doctor = doctors[index];

              return ListTile(

                title: Text(doctor['name']),

                subtitle: Text('تخصص: ${doctor['specialty']}'),

                trailing: ElevatedButton(

                  onPressed: () {

                    // التواصل مع الطبيب عبر واتساب

                  },

                  child: Text('تواصل مع الطبيب'),

                ),

              );

            },

          );

        },

      ),

    );

  }

}