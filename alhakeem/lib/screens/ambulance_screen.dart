import 'package:flutter/material.dart';

class AmbulanceScreen extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text('طلب سيارة إسعاف')),

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Text('سيارة الإسعاف موجودة في الموقع التالي:'),

            Text('الموقع: المدينة، الشارع 123'),

            Text('رقم اللوحة: XYZ 1234'),

            Text('اسم السائق: أحمد'),

            ElevatedButton(

              onPressed: () {

                // الاتصال برقم السائق

              },

              child: Text('اتصال بالسائق'),

            ),

          ],

        ),

      ),

    );

  }

}