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
  ai,
  prompt;

  @override
  String toString() {
    return name;
  }
}
