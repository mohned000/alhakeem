import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class PhysicalTherapyScreen extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text('طلب معالج طبيعي')),

      body: FutureBuilder(

        future: FirebaseFirestore.instance.collection('physiotherapists').get(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {

            return Center(child: CircularProgressIndicator());

          }

          final therapists = snapshot.data!.docs;

          return ListView.builder(

            itemCount: therapists.length,

            itemBuilder: (context, index) {

              final therapist = therapists[index];

              return ListTile(

                title: Text(therapist['name']),

                subtitle: Text('تخصص: ${therapist['specialty']}'),

                trailing: ElevatedButton(

                  onPressed: () {

                    // التواصل مع المعالج الطبيعي عبر واتساب

                  },

                  child: Text('تواصل مع المعالج الطبيعي'),

                ),

              );

            },

          );

        },

      ),

    );

  }

}