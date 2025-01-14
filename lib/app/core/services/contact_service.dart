import 'package:easy_scanner/app/data/models/businesss_card_model.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class ContactService {
  static createNewContact(BusinessCardModel businessCardModel) async {
    if (await FlutterContacts.requestPermission()) {
      final nameSplit = businessCardModel.name?.split(' ');

      final lastName = nameSplit?.last ?? '';
      nameSplit?.removeLast();
      final firstName = nameSplit?.join(' ');

      final newContact = Contact()
        ..name.first = firstName ?? ''
        ..name.last = lastName
        ..phones = [Phone(businessCardModel.phone ?? '')]
        ..emails = [Email(businessCardModel.email ?? '')]
        ..organizations = [
          Organization(company: businessCardModel.company ?? '')
        ];
      final contact = await FlutterContacts.openExternalInsert(newContact);
    }
  }

  static Future<void> dialNumber(String number) async {
    try {
      final uri = Uri(scheme: 'tel', path: number);
      await launchUrl(uri);
    } catch (_) {}
  }

  static Future<void> sendSMS(String number, String? sms) async {
    try {
      final uri = Uri(
        scheme: 'sms',
        path: number,
        queryParameters: {'body': sms ?? ''},
      );
      await launchUrl(uri);
    } catch (_) {}
  }

  static Future<void> sendEmail(
      {required String email, String? sub, String? body}) async {
    try {
      final uri = Uri(
        scheme: 'mailto',
        path: email,
        query:
            'subject=${Uri.encodeComponent(sub ?? '')}&body=${Uri.encodeComponent(body ?? 'Dear')}',
      );

      await launchUrl(uri);
    } catch (_) {}
  }
}
