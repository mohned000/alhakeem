class Lab {

  final String labName;

  final String labLocation;

  final String contactUrl;

  Lab({

    required this.labName,

    required this.labLocation,

    required this.contactUrl,

  });

  factory Lab.fromMap(Map<String, dynamic> data) {

    return Lab(

      labName: data['labName'] ?? '',

      labLocation: data['labLocation'] ?? '',

      contactUrl: data['contactUrl'] ?? '',

    );

  }

  Map<String, dynamic> toMap() {

    return {

      'labName': labName,

      'labLocation': labLocation,

      'contactUrl': contactUrl,

    };

  }

}