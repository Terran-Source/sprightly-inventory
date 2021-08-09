library marganam.json_util;

void extend(Map<String, dynamic> target, Map<String, dynamic> source) {
  source.forEach((key, val) {
    if (target.containsKey(key)) {
      if (source[key] is! Map<String, dynamic>) {
        target[key] = source[key];
      } else if (target[key] is! Map<String, dynamic>) {
        target[key] = source[key];
      } else {
        extend(target[key] as Map<String, dynamic>,
            source[key] as Map<String, dynamic>);
      }
    } else {
      target[key] = source[key];
    }
  });
}
