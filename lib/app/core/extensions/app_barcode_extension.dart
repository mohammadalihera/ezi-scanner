import 'dart:developer';
import 'dart:ui';
import 'dart:typed_data';
import 'package:mobile_scanner/mobile_scanner.dart';

extension BarcodeJsonExtension on Barcode {
  Map<String, dynamic> toJson() {
    return {
      'calendarEvent': calendarEvent?.toJson(),
      'contactInfo': contactInfo?.toJson(),
      'corners':
          corners.map((corner) => {'dx': corner.dx, 'dy': corner.dy}).toList(),
      'displayValue': displayValue,
      'driverLicense': driverLicense?.toJson(),
      'email': email?.toJson(),
      'format': format.toString(),
      'geoPoint': geoPoint?.toJson(),
      'phone': phone?.toJson(),
      'rawBytes': rawBytes?.toList(),
      'rawValue': rawValue,
      'size': {'width': size.width, 'height': size.height},
      'sms': sms?.toJson(),
      'type': type.toString(),
      'url': url?.toJson(),
      'wifi': wifi?.toJson(),
      'timeStamp': DateTime.now().toIso8601String(),
    };
  }

  static Barcode? fromJson(Map<String, dynamic> json) {
    try {
      return Barcode(
        calendarEvent: json['calendarEvent'] != null
            ? CalendarEventJsonExtension.fromJson(json['calendarEvent'])
            : null,
        contactInfo: json['contactInfo'] != null
            ? ContactInfoJsonExtension.fromJson(json['contactInfo'])
            : null,
        corners: (json['corners'] as List<dynamic>)
            .map(
              (corner) => Offset(
                double.tryParse(corner['dx'].toString()) ?? 0,
                double.tryParse(corner['dy'].toString()) ?? 0,
              ),
            )
            .toList(),
        displayValue: json['displayValue'],
        driverLicense: json['driverLicense'] != null
            ? DriverLicenseJson.fromJson(json['driverLicense'])
            : null,
        email: json['email'] != null ? EmailJson.fromJson(json['email']) : null,
        format: BarcodeFormat.values.firstWhere(
          (format) => format.toString() == json['format'],
          orElse: () => BarcodeFormat.unknown,
        ),
        geoPoint: json['geoPoint'] != null
            ? GeoPointJson.fromJson(json['geoPoint'])
            : null,
        phone: json['phone'] != null ? PhoneJson.fromJson(json['phone']) : null,
        rawBytes: json['rawBytes'] != null
            ? Uint8List.fromList(List<int>.from(json['rawBytes']))
            : null,
        rawValue: json['rawValue'],
        size: json['size'] != null
            ? Size(json['size']['width'], json['size']['height'])
            : Size.zero,
        sms: json['sms'] != null ? SMSJson.fromJson(json['sms']) : null,
        type: BarcodeType.values.firstWhere(
          (type) => type.toString() == json['type'],
          orElse: () => BarcodeType.unknown,
        ),
        url: json['url'] != null ? UrlBookmarkJson.fromJson(json['url']) : null,
        wifi: json['wifi'] != null ? WiFiJson.fromJson(json['wifi']) : null,
      );
    } catch (error) {
      log(error.toString());
      return null;
    }
  }
}

extension CalendarEventJsonExtension on CalendarEvent {
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'start': start?.toIso8601String(),
      'end': end?.toIso8601String(),
      'location': location,
      'organizer': organizer,
      'status': status,
      'summary': summary,
    };
  }

  static CalendarEvent fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      description: json['description'] as String?,
      start: json['start'] != null
          ? DateTime.tryParse(json['start'] as String)
          : null,
      end:
          json['end'] != null ? DateTime.tryParse(json['end'] as String) : null,
      location: json['location'] as String?,
      organizer: json['organizer'] as String?,
      status: json['status'] as String?,
      summary: json['summary'] as String?,
    );
  }
}

extension ContactInfoJsonExtension on ContactInfo {
  Map<String, dynamic> toJson() {
    return {
      'addresses': addresses.map((address) => address.toJson()).toList(),
      'emails': emails.map((email) => email.toJson()).toList(),
      'name': name?.toJson(),
      'organization': organization,
      'phones': phones.map((phone) => phone.toJson()).toList(),
      'title': title,
      'urls': urls,
    };
  }

  static ContactInfo fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      addresses: (json['addresses'] as List<dynamic>?)
              ?.map((address) =>
                  AddressJson.fromJson(address as Map<String, dynamic>))
              .toList() ??
          const <Address>[],
      emails: (json['emails'] as List<dynamic>?)
              ?.map(
                  (email) => EmailJson.fromJson(email as Map<String, dynamic>))
              .toList() ??
          const <Email>[],
      name: json['name'] != null
          ? PersonNameJson.fromJson(json['name'] as Map<String, dynamic>)
          : null,
      organization: json['organization'] as String?,
      phones: (json['phones'] as List<dynamic>?)
              ?.map(
                  (phone) => PhoneJson.fromJson(phone as Map<String, dynamic>))
              .toList() ??
          const <Phone>[],
      title: json['title'] as String?,
      urls:
          (json['urls'] as List<dynamic>?)?.cast<String>() ?? const <String>[],
    );
  }
}

extension DriverLicenseJson on DriverLicense {
  Map<String, dynamic> toJson() {
    return {
      'addressCity': addressCity,
      'addressState': addressState,
      'addressStreet': addressStreet,
      'addressZip': addressZip,
      'birthDate': birthDate,
      'documentType': documentType,
      'expiryDate': expiryDate,
      'firstName': firstName,
      'gender': gender,
      'issueDate': issueDate,
      'issuingCountry': issuingCountry,
      'lastName': lastName,
      'licenseNumber': licenseNumber,
      'middleName': middleName,
    };
  }

  // Convert JSON to DriverLicense
  static DriverLicense fromJson(Map<String, dynamic> json) {
    return DriverLicense(
      addressCity: json['addressCity'] as String?,
      addressState: json['addressState'] as String?,
      addressStreet: json['addressStreet'] as String?,
      addressZip: json['addressZip'] as String?,
      birthDate: json['birthDate'] as String?,
      documentType: json['documentType'] as String?,
      expiryDate: json['expiryDate'] as String?,
      firstName: json['firstName'] as String?,
      gender: json['gender'] as String?,
      issueDate: json['issueDate'] as String?,
      issuingCountry: json['issuingCountry'] as String?,
      lastName: json['lastName'] as String?,
      licenseNumber: json['licenseNumber'] as String?,
      middleName: json['middleName'] as String?,
    );
  }
}

extension EmailJson on Email {
  // Convert Email to JSON
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'body': body,
      'subject': subject,
      'type': type.rawValue,
      // Assuming EmailType has a `rawValue` property for conversion
    };
  }

  // Convert JSON to Email
  static Email fromJson(Map<String, dynamic> json) {
    return Email(
      address: json['address'] as String?,
      body: json['body'] as String?,
      subject: json['subject'] as String?,
      type: EmailType.fromRawValue(json['type'] as int? ??
          0), // Assuming fromRawValue is a method in EmailType
    );
  }
}

extension GeoPointJson on GeoPoint {
  // Convert GeoPoint to JSON
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // Convert JSON to GeoPoint
  static GeoPoint fromJson(Map<String, dynamic> json) {
    return GeoPoint(
      latitude: json['latitude'] as double? ?? 0.0,
      // Default to 0.0 if not present
      longitude:
          json['longitude'] as double? ?? 0.0, // Default to 0.0 if not present
    );
  }
}

extension PhoneJson on Phone {
  // Convert Phone to JSON
  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'type': type.rawValue,
      // Assuming PhoneType has a `rawValue` property for conversion
    };
  }

  // Convert JSON to Phone
  static Phone fromJson(Map<String, dynamic> json) {
    return Phone(
      number: json['number'] as String?,
      type: PhoneType.fromRawValue(json['type'] as int? ??
          0), // Assuming fromRawValue is a method in PhoneType
    );
  }
}

extension SMSJson on SMS {
  // Convert SMS to JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'phoneNumber': phoneNumber,
    };
  }

  // Convert JSON to SMS
  static SMS fromJson(Map<String, dynamic> json) {
    return SMS(
      message: json['message'] as String?,
      phoneNumber: json['phoneNumber'] as String? ?? '',
    );
  }
}

extension UrlBookmarkJson on UrlBookmark {
  // Convert UrlBookmark to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': url,
    };
  }

  // Convert JSON to UrlBookmark
  static UrlBookmark fromJson(Map<String, dynamic> json) {
    return UrlBookmark(
      title: json['title'] as String?,
      url: json['url'] as String? ?? '',
    );
  }
}

extension WiFiJson on WiFi {
  // Convert WiFi to JSON
  Map<String, dynamic> toJson() {
    return {
      'encryptionType': encryptionType.rawValue,
      'ssid': ssid,
      'password': password,
    };
  }

  // Convert JSON to WiFi
  static WiFi fromJson(Map<String, dynamic> json) {
    return WiFi(
      encryptionType:
          EncryptionType.fromRawValue(json['encryptionType'] as int? ?? 0),
      ssid: json['ssid'] as String?,
      password: json['password'] as String?,
    );
  }
}

extension AddressJson on Address {
  // Convert Address to JSON
  Map<String, dynamic> toJson() {
    return {
      'addressLines': addressLines,
      'type': type.rawValue,
    };
  }

  // Convert JSON to Address
  static Address fromJson(Map<String, dynamic> json) {
    final List<Object?>? addressLines = json['addressLines'] as List<Object?>?;
    final AddressType type =
        AddressType.fromRawValue(json['type'] as int? ?? 0);

    if (addressLines == null) {
      return Address(type: type);
    }

    return Address(
      addressLines: List.unmodifiable(addressLines.cast<String>()),
      type: type,
    );
  }
}

extension PersonNameJson on PersonName {
  // Convert PersonName to JSON
  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'middle': middle,
      'last': last,
      'prefix': prefix,
      'suffix': suffix,
      'formattedName': formattedName,
      'pronunciation': pronunciation,
    };
  }

  // Convert JSON to PersonName
  static PersonName fromJson(Map<String, dynamic> json) {
    return PersonName(
      first: json['first'] as String?,
      middle: json['middle'] as String?,
      last: json['last'] as String?,
      prefix: json['prefix'] as String?,
      suffix: json['suffix'] as String?,
      formattedName: json['formattedName'] as String?,
      pronunciation: json['pronunciation'] as String?,
    );
  }
}
