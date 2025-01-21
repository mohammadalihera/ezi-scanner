extension StringValidator on String {
  /// Check if the string is a valid email.
  bool get isValidEmail {
    final regex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return regex.hasMatch(this);
  }

  /// Check if the string is a valid phone number.
  bool get isValidPhoneNumber {
    final regex = RegExp(
        r'^(\+\d{1,3})?[-.\s]?\(?\d{1,4}\)?[-.\s]?\d{1,4}[-.\s]?\d{1,9}$');
    return regex.hasMatch(this);
  }

  /// Check if the string is a valid URL.
  bool get isValidUrl {
    final regex = RegExp(
        r'^(https?:\/\/)?([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,6}(:\d+)?(\/.*)?$');
    return regex.hasMatch(this);
  }

  /// Check if the string is a valid URL using Uri class.
  bool get isValidUri {
    try {
      final uri = Uri.parse(this);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }
}
