String normalizeSearch(String value) {
  return value
      .toLowerCase()
      .replaceAll(RegExp(r"[^a-z0-9\s]"), '')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}
