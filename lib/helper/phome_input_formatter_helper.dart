import 'package:flutter/services.dart';

class PhoneInputFormatterHelper extends TextInputFormatter {
  final String countryCode;

  PhoneInputFormatterHelper(this.countryCode);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (newText.startsWith("0")) newText = newText.replaceFirst("0", "", 0);

    if(countryCode == "+58") newText.length > 10 ? newText = newText.substring(0, 10) : newText = newText;
    if(countryCode != "+58") newText.length > 15 ? newText = newText.substring(0, 15) : newText = newText;

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
