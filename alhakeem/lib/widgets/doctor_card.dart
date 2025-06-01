import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class DoctorCard extends StatelessWidget {

  final String name;

  final String specialty;

  final String imageUrl;

  final String whatsappUrl;

  DoctorCard({

    required this.name,

    required this.specialty,

    required this.imageUrl,

    required this.whatsappUrl,

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

        leading: Image.asset(imageUrl),

        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),

        subtitle: Text(specialty),

        trailing: IconButton(

          icon: Icon(Icons.chat),

          onPressed: () async {

            if (await canLaunch(whatsappUrl)) {

              await launch(whatsappUrl);

            } else {

              throw 'Could not launch $whatsappUrl';

            }

          },

        ),

      ),

    );

  }

}