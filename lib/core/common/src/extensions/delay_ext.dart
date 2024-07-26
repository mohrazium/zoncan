part of 'extensions.dart';

extension DelayedExtension<T> on T {
  Future<T> toFuture([Duration? delay]) =>
      delay != null ? Future.delayed(delay, () => this) : Future.value(this);
}
