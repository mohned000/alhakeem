import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class LabCard extends StatelessWidget {

  final String labName;

  final String labLocation;

  final String contactUrl; // رابط التواصل مع المعمل

  LabCard({

    required this.labName,

    required this.labLocation,

    required this.contactUrl,

  });

  @override

  Widget build(BuildContext context) {

    return Card(

      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),

      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(10),

      ),

      child: ListTile(

        contentPadding: EdgeInsets.all(15),

        title: Text(labName, style: TextStyle(fontWeight: FontWeight.bold)),

        subtitle: Text(labLocation),

        trailing: IconButton(

          icon: Icon(Icons.phone),

          onPressed: () async {

            if (await canLaunch(contactUrl)) {

              await launch(contactUrl);

            } else {

              throw 'Could not launch $contactUrl';

            }

          },

        ),

      ),

    );

  }

}