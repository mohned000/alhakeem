class Doctor {

  final String name;

  final String specialty;

  final String imageUrl;

  final String whatsappUrl;

  Doctor({

    required this.name,

    required this.specialty,

    required this.imageUrl,

    required this.whatsappUrl,

  });

  factory Doctor.fromMap(Map<String, dynamic> data) {

    return Doctor(

      name: data['name'] ?? '',

      specialty: data['specialty'] ?? '',

      imageUrl: data['imageUrl'] ?? '',

      whatsappUrl: data['whatsappUrl'] ?? '',

    );

  }

  Map<String, dynamic> toMap() {

    return {

      'name': name,

      'specialty': specialty,

      'imageUrl': imageUrl,

      'whatsappUrl': whatsappUrl,

    };

  }

}