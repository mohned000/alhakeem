import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class CtMriScreen extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text('أماكن توفر CT و MRI')),

      body: FutureBuilder(

        future: FirebaseFirestore.instance.collection('hospitals').get(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {

            return Center(child: CircularProgressIndicator());

          }

          final hospitals = snapshot.data!.docs;

          return ListView.builder(

            itemCount: hospitals.length,

            itemBuilder: (context, index) {

              final hospital = hospitals[index];

              return ListTile(

                title: Text(hospital['name']),

                subtitle: Text('موقع: ${hospital['location']}'),

                trailing: ElevatedButton(

                  onPressed: () {

                    // عرض معلومات CT و MRI

                  },

                  child: Text('عرض التفاصيل'),

                ),

              );

            },

          );

        },

      ),

    );

  }

}