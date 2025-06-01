import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'ambulance_screen.dart'; // صفحة طلب سيارة الإسعاف

import 'doctor_consultation.dart'; // صفحة استشارة الطبيب

import 'lab_test_screen.dart'; // صفحة فحص عينة

import 'medicine_search_screen.dart'; // صفحة البحث عن دواء

import 'appointments_screen.dart'; // صفحة حجز مواعيد العيادات

import 'nurse_request_screen.dart'; // صفحة طلب ممرض

import 'physical_therapy_screen.dart'; // صفحة طلب معالج طبيعي

import 'ct_mri_screen.dart'; // صفحة أماكن توفر CT و MRI

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> _medicalServices = [
    {
      'icon': Icons.medical_services,
      'title': 'طلب إسعاف',
      'screen': AmbulanceScreen(),
      'color': Colors.red,
    },
    {
      'icon': Icons.person,
      'title': 'استشارة طبيب',
      'screen': DoctorChatScreen(),
      'color': Colors.blue,
    },
    {
      'icon': Icons.science,
      'title': 'فحص مخبري',
      'screen': LabTestScreen(),
      'color': Colors.green,
    },
    {
      'icon': Icons.local_pharmacy,
      'title': 'بحث عن دواء',
      'screen': MedicineSearchScreen(),
      'color': Colors.orange,
    },
    {
      'icon': Icons.calendar_today,
      'title': 'حجز موعد',
      'screen': AppointmentsScreen(),
      'color': Colors.purple,
    },
    {
      'icon': Icons.healing,
      'title': 'طلب ممرض',
      'screen': NurseRequestScreen(),
      'color': Colors.teal,
    },
    {
      'icon': Icons.accessibility_new,
      'title': 'علاج طبيعي',
      'screen': PhysicalTherapyScreen(),
      'color': Colors.indigo,
    },
    {
      'icon': Icons.image,
      'title': 'أشعة CT/MRI',
      'screen': CtMriScreen(),
      'color': Colors.brown,
    },
  ];

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.red),
          SizedBox(height: 16),
          Text(message),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.currentUser?.reload();
            },
            child: Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: _medicalServices.length,
      itemBuilder: (context, index) {
        final service = _medicalServices[index];
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => service['screen'] as Widget),
            ),
            borderRadius: BorderRadius.circular(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: service['color'].withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    service['icon'] as IconData,
                    size: 32,
                    color: service['color'],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  service['title'] as String,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('الرئيسية'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _buildErrorWidget('حدث خطأ في تحميل البيانات');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final userData = snapshot.data?.data() as Map<String, dynamic>?;
          
          return RefreshIndicator(
            onRefresh: () async {
              await user?.reload();
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مرحباً ${userData?['username'] ?? 'مستخدم'}',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'كيف يمكننا مساعدتك اليوم؟',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'الخدمات الطبية',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildServicesGrid(),
                  SizedBox(height: 20),
                  if (userData != null) ...[
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Card(
                        child: ListTile(
                          leading: Icon(Icons.phone, color: Theme.of(context).primaryColor),
                          title: Text('رقم الهاتف'),
                          subtitle: Text(userData['phone'] ?? ''),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
