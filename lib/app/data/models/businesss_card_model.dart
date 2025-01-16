class BusinessCardModel {
  String? name;
  String? phone;
  String? email;
  String? address;
  String? company;
  String? website;
  String? imagePath;
  String? timeStamp;

  BusinessCardModel({
    this.name,
    this.phone,
    this.email,
    this.company,
    this.address,
    this.website,
    this.imagePath,
    this.timeStamp,
  });

  @override
  String toString() {
    return '''
    Name: $name
    Phone: $phone
    Email: $email
    Company: $company
    Address: $address
    Website: $website
    ImagePath: $imagePath
    TimeStamp: $timeStamp
    ''';
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'company': company,
      'website': website,
      'imagePath': imagePath,
      'timeStamp': DateTime.now().toIso8601String(),
    };
  }

  factory BusinessCardModel.fromJson(Map<String, dynamic> map) {
    return BusinessCardModel(
      name: map['name']?.toString(),
      phone: map['phone']?.toString(),
      email: map['email']?.toString(),
      address: map['address']?.toString(),
      company: map['company']?.toString(),
      website: map['website']?.toString(),
      imagePath: map['imagePath']?.toString(),
      timeStamp: map['timeStamp']?.toString(),
    );
  }

  static BusinessCardModel parseContact(String data) {
    String? name, phone, email, company, address, website;

    if (data.startsWith("MECARD:")) {
      final fields = data.substring(7).split(';');
      for (var field in fields) {
        if (field.startsWith('N:')) {
          name = field.substring(2).trim();
        } else if (field.startsWith('TEL:')) {
          phone = field.substring(4).trim();
        } else if (field.startsWith('EMAIL:')) {
          email = field.substring(6).trim();
        } else if (field.startsWith('ADR:')) {
          address = field.substring(4).trim();
        } else if (field.startsWith('ORG:')) {
          company = field.substring(4).trim();
        } else if (field.startsWith('URL:')) {
          website = field.substring(4).trim();
        }
      }
    } else if (data.startsWith("BEGIN:VCARD")) {
      final lines = data.split('\n');
      for (var line in lines) {
        if (line.startsWith('N:')) {
          final parts = line.substring(2).split(';');
          name = parts.reversed.join(' ').trim();
        } else if (line.startsWith('FN:')) {
          name ??= line.substring(3).trim(); // Use FN if N is missing
        } else if (line.startsWith('TEL:')) {
          phone = line.substring(4).trim();
        } else if (line.startsWith('EMAIL:')) {
          email = line.substring(6).trim();
        } else if (line.startsWith('ORG:')) {
          company = line.substring(4).trim();
        } else if (line.startsWith('ADR:')) {
          address = line.substring(4).trim();
        } else if (line.startsWith('URL:')) {
          website = line.substring(4).trim();
        }
      }
    }

    return BusinessCardModel(
      name: name,
      phone: phone,
      email: email,
      company: company,
      address: address,
      website: website,
    );
  }
}

class SmsData {
  String? phone;
  String? sms;

  SmsData({this.phone, this.sms});

  @override
  String toString() {
    return '''
    Phone: $phone
    sms: $sms
    ''';
  }

  static SmsData parseSms(String smsString) {
    final parts = smsString.replaceFirst('SMSTO:', '').split(':');

    String phone = '';
    String sms = '';

    phone = parts[0];
    sms = parts[1];

    return SmsData(phone: phone, sms: sms);
  }
}

class EmailData {
  String? email;
  String? sub;
  String? body;

  EmailData({this.email, this.sub, this.body});

  @override
  String toString() {
    return '''
    Email: $email
    Sub: $sub
    Body: $body
    ''';
  }

  static EmailData parseEmail(String emailString) {
    final parts = emailString.replaceFirst('MATMSG:', '').split(';');

    String email = '';
    String sub = '';
    String body = '';

    for (var part in parts) {
      if (part.startsWith('TO:')) {
        email = part.substring(3);
      } else if (part.startsWith('SUB:')) {
        sub = part.substring(4);
      } else if (part.startsWith('BODY:')) {
        body = part.substring(5);
      }
    }

    return EmailData(email: email, sub: sub, body: body);
  }
}
