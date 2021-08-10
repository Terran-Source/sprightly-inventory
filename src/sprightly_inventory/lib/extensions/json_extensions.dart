library marganam.extensions;

extension JsonExt on Map {
  Map extend(Map source, [Iterable<Map>? sources]) {
    source.forEach((key, val) {
      if (containsKey(key)) {
        if (source[key] is! Map) {
          this[key] = source[key];
        } else if (this[key] is! Map) {
          this[key] = source[key];
        } else {
          this[key].extend(source[key] as Map);
        }
      } else {
        this[key] = source[key];
      }
    });
    if (null != sources && sources.isNotEmpty) {
      final nextSource = sources.first;
      final nextSources = sources.skip(1);
      extend(nextSource, nextSources);
    }
    return this;
  }
}
