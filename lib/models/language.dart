enum Language {
  english,
  spanish,
  french,
  german,
  chinese,
  japanese,
  russian,
  portuguese,
  arabic,
  hindi,
  bengali,
  urdu,
  vietnamese,
  turkish,
  italian,
}

extension ParseToString on Language {
  String toShortString() {
    return toString().split('.').last;
  }
}
