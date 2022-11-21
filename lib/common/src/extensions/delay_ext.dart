part of common.extensions;

extension DelayedExtension<T> on T {
  Future<T> toFuture([Duration? delay]) =>
      delay != null ? Future.delayed(delay, () => this) : Future.value(this);
}

Future<void> t() async {
  final bool c = await true.toFuture();
}
