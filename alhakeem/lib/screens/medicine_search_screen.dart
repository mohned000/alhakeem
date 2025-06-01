import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class MedicineSearchScreen extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text('البحث عن دواء')),

      body: FutureBuilder(

        future: FirebaseFirestore.instance.collection('pharmacies').get(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {

            return Center(child: CircularProgressIndicator());

          }

          final pharmacies = snapshot.data!.docs;

          return ListView.builder(

            itemCount: pharmacies.length,

            itemBuilder: (context, index) {

              final pharmacy = pharmacies[index];

              return ListTile(

                title: Text(pharmacy['name']),

                subtitle: Text('موقع: ${pharmacy['location']}'),

                trailing: ElevatedButton(

                  onPressed: () {

                    // التواصل مع الصيدلية عبر واتساب

                  },

                  child: Text('تواصل عبر واتساب'),

                ),

              );

            },

          );

        },

      ),

    );

  }

}