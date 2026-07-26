class Service_Addproduct {
  static String generateUniqueId(String categories) {
    const categoryPrefixes = {
      '##-pizza': 'P',
      '##-burger': 'B',
      '##-sandwich': 'S',
      '##-taccos': 'T',
      '##-jues': 'J',
      '##-kaick': 'K',
    };
    final prefix = categoryPrefixes[categories] ?? 'ZXZ';
    final timestamp = DateTime.now().microsecondsSinceEpoch.toString();
    return "$prefix-$timestamp";
  }
}
