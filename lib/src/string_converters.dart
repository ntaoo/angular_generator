String toHyphenCase(String snakeCaseText) {
  assert(isSnakeCaseText(snakeCaseText));
  return snakeCaseText.replaceAll(RegExp(r'_'), '-');
}

String toPascalCase(String snakeCaseText) {
  assert(isSnakeCaseText(snakeCaseText));
  List<String> s = snakeCaseText.split('_');
  return s
      .map((s) => s.replaceFirstMapped(
          RegExp(r'.'), (match) => match.group(0).toUpperCase()))
      .join();
}

bool isSnakeCaseText(String text) {
  if (text == null || text.isEmpty) return false;
  // A to Z, hyphen, any space.
  if (text.contains(RegExp(r'[A-Z\-\s]'))) return false;
  return true;
}
