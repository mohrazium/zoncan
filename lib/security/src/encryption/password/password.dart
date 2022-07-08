import 'algorithm.dart';
import 'algorithms/pbkdf2.dart';

/// Holds static methods as a module.
class Password {
  /// Hashed the given plain-text [password] using the given [algorithm].
  static String hash(String password, [Algorithm? algorithm]) {
    algorithm = PBKDF2(blockLength: 16,desiredKeyLength: 16,iterationCount: 2500);
    return algorithm.process(password);
  }

  /// Checks if the given plain-text [password] matches the given encoded [hash].
  static bool verify(String password, String hash) {
    final algorithm = Algorithm.decode(hash);
    return algorithm.process(password) == hash;
  }
}
