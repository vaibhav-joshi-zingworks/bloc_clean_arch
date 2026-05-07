/// Enumerates the supported persistence engines available in the application.
enum StorageEngine { 
  /// Standard key-value storage for simple preferences.
  sharedPreferences, 
  
  /// Encrypted storage for sensitive information like auth tokens.
  secureStorage, 
  
  /// Lightweight and fast NoSQL database.
  hive, 
  
  /// High-performance cross-platform NoSQL database.
  isar, 
  
  /// Relational database (SQLite) for complex structured data.
  drift 
}
