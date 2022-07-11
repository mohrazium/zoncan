part of cryptography.core;

abstract class Cryptology<A, D> {
  late final A algorithm;
  Cryptology({
    required this.algorithm,
  });
  dynamic encrypt(D data);
  dynamic decrypt(D hashedData);
  dynamic verify(D data, D hashedData);
  dynamic hash(D data);
}
