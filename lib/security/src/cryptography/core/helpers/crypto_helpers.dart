part of cryptography.core;

/// Extension on String for convert them to Uint8List.
extension CryptoHelpersString on String {
  toUint8List() => CryptoHelpers.createUint8ListFromHexString(this);
}

/// Extension on Uint8List for convert them to String.
extension CryptoHelpersUint8List on Uint8List {
  toNormalString() => CryptoHelpers.toHexStringFromBytes(this);
}

class CryptoHelpers {
  /// Creates a hexadecimal representation of the given [bytes].
  static String toHexStringFromBytes(Uint8List bytes) {
    var result = StringBuffer();
    for (var i = 0; i < bytes.lengthInBytes; i++) {
      var part = bytes[i];
      result.write('${part < 16 ? '0' : ''}${part.toRadixString(16)}');
    }
    return result.toString();
  }

  /// Creates binary data from the given [hex] hexadecimal String.
  static Uint8List createUint8ListFromHexString(String hex) {
    return Uint8List.fromList(utf8.encode(hex));
  }

  /// Simply convert a [bytes] to string.
  static String toStringFromBytes(Uint8List bytes) =>
      String.fromCharCodes(bytes);

  /// Encode a [bytes] to base64 encoded string.
  static String toBase64String(Uint8List bytes) => base64.encode(bytes);

  /// Decode a [base64Coded] string to corresponding string.
  static String toStringBase64(String base64Coded) =>
      utf8.decode(base64.decode(base64Coded));

  static bool compare(Uint8List leftByte, Uint8List rightBytes) {
    if (identical(leftByte, rightBytes)) {
      return true;
    }

    if (leftByte.lengthInBytes != rightBytes.lengthInBytes) {
      return false;
    }

    // Treat the original byte lists as lists of 8-byte words.
    var numWords = leftByte.lengthInBytes ~/ 8;
    var leftWords = leftByte.buffer.asUint64List(0, numWords);
    var rightWords = rightBytes.buffer.asUint64List(0, numWords);

    for (var i = 0; i < leftWords.length; i += 1) {
      if (leftWords[i] != rightWords[i]) {
        return false;
      }
    }

    // Compare any remaining bytes.
    for (var i = leftWords.lengthInBytes; i < leftByte.lengthInBytes; i += 1) {
      if (leftByte[i] != rightBytes[i]) {
        return false;
      }
    }

    return true;
  }
}
