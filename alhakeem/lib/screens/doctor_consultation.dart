import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

// Model class for doctor's information
class DoctorInfo {
  final String name;
  final String bio;
  final String whatsapp;

  DoctorInfo({
    required this.name,
    required this.bio,
    required this.whatsapp,
  });
}

// Public stateful widget
class DoctorChatScreen extends StatefulWidget {
  const DoctorChatScreen({super.key});

  @override
  DoctorChatScreenState createState() => DoctorChatScreenState();
}

// Public State class (was _DoctorChatScreenState)
class DoctorChatScreenState extends State<DoctorChatScreen> {
  DoctorInfo? doctor;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDoctorInfo();
  }

  // Fetch the first doctor's data from Firestore
  Future<void> fetchDoctorInfo() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        setState(() {
          doctor = DoctorInfo(
            name: data['name'] ?? 'غير معروف',
            bio: data['bio'] ?? 'لا توجد سيرة ذاتية',
            whatsapp: data['whatsapp'] ?? '',
          );
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      print('حدث خطأ أثناء جلب البيانات: $e');
      setState(() => isLoading = false);
    }
  }

  // Launch WhatsApp chat
  void openWhatsApp(String number) async {
  final url = "https://wa.me/$number";

  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } else {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("تعذر فتح واتساب")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('محادثة مع الطبيب')),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : doctor == null
                ? const Text('لم يتم العثور على طبيب')
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "الاسم: ${doctor!.name}",
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "نبذة: ${doctor!.bio}",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.chat),
                          label: const Text("تواصل عبر واتساب"),
                          onPressed: () => openWhatsApp(doctor!.whatsapp),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
