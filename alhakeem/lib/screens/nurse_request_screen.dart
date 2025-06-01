import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class NurseRequestScreen extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text('طلب ممرض')),

      body: FutureBuilder(

        future: FirebaseFirestore.instance.collection('nurses').get(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {

            return Center(child: CircularProgressIndicator());

          }

          final nurses = snapshot.data!.docs;

          return ListView.builder(

            itemCount: nurses.length,

            itemBuilder: (context, index) {

              final nurse = nurses[index];

              return ListTile(

                title: Text(nurse['name']),

                subtitle: Text('تخصص: ${nurse['specialty']}'),

                trailing: ElevatedButton(

                  onPressed: () {

                    // التواصل مع الممرض عبر واتساب

                  },

                  child: Text('تواصل مع الممرض'),

                ),

              );

            },

          );

        },

      ),

    );

  }

}