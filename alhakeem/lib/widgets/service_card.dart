import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class ServiceCard extends StatelessWidget {

  final String title;

  final String description;

  final String imageUrl;

  final String contactUrl; // رابط الواتساب أو الهاتف

  ServiceCard({

    required this.title,

    required this.description,

    required this.imageUrl,

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

        leading: Image.asset(imageUrl),

        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),

        subtitle: Text(description),

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