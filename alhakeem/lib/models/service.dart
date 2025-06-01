class Service {

  final String title;

  final String description;

  final String imageUrl;

  final String contactUrl;

  Service({

    required this.title,

    required this.description,

    required this.imageUrl,

    required this.contactUrl,

  });

  factory Service.fromMap(Map<String, dynamic> data) {

    return Service(

      title: data['title'] ?? '',

      description: data['description'] ?? '',

      imageUrl: data['imageUrl'] ?? '',

      contactUrl: data['contactUrl'] ?? '',

    );

  }

  Map<String, dynamic> toMap() {

    return {

      'title': title,

      'description': description,

      'imageUrl': imageUrl,

      'contactUrl': contactUrl,

    };

  }

}