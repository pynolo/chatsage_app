enum Attitude {
  kind,
  joking,
  offensive;

  @override
  String toString() {
    return name;
  }
}

enum Speaker {
  human,
  ai;

  @override
  String toString() {
    return name;
  }
}
