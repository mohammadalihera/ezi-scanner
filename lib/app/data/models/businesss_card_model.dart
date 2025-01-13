class BusinessCardModel {
  String? name;
  String? phone;
  String? email;
  String? address;
  String? company;
  String? website;

  BusinessCardModel({
    this.name,
    this.phone,
    this.email,
    this.company,
    this.address,
    this.website,
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
    ''';
  }

  static BusinessCardModel parseContact(String vcard) {
    final lines = vcard.split('\n');
    String? name, phone, email, company, address, website;

    for (var line in lines) {
      if (line.startsWith('N:')) {
        final parts = line.substring(2).split(';');
        name = parts.reversed.join(' ').trim();
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
