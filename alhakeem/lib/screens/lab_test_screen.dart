import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class LabTestScreen extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text('فحص عينة')),

      body: FutureBuilder(

        future: FirebaseFirestore.instance.collection('labs').get(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {

            return Center(child: CircularProgressIndicator());

          }

          final labs = snapshot.data!.docs;

          return ListView.builder(

            itemCount: labs.length,

            itemBuilder: (context, index) {

              final lab = labs[index];

              return ListTile(

                title: Text(lab['name']),

                subtitle: Text('موقع: ${lab['location']}'),

                trailing: ElevatedButton(

                  onPressed: () {

                    // عرض الفحوصات المتاحة

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) => TestRequestScreen(labId: lab.id),

                      ),

                    );

                  },

                  child: Text('طلب فحص'),

                ),

              );

            },

          );

        },

      ),

    );

  }

}

class TestRequestScreen extends StatelessWidget {

  final String labId;

  TestRequestScreen({required this.labId});

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text('اختيارات الفحوصات')),

      body: FutureBuilder(

        future: FirebaseFirestore.instance

            .collection('labs')

            .doc(labId)

            .collection('tests')

            .get(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {

            return Center(child: CircularProgressIndicator());

          }

          final tests = snapshot.data!.docs;

          return ListView.builder(

            itemCount: tests.length,

            itemBuilder: (context, index) {

              final test = tests[index];

              return ListTile(

                title: Text(test['name']),

                trailing: Checkbox(

                  value: test['isChecked'],

                  onChanged: (value) {

                    // تحديث حالة الاختيار

                    FirebaseFirestore.instance

                        .collection('labs')

                        .doc(labId)

                        .collection('tests')

                        .doc(test.id)

                        .update({'isChecked': value});

                  },

                ),

              );

            },

          );

        },

      ),

    );

  }

}