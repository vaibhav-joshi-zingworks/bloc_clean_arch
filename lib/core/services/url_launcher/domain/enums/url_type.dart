/// Classifies the different types of external URL protocols supported by the app.
enum UrlType { 
  /// Standard HTTP/HTTPS web links.
  web, 
  
  /// Email composition links.
  mailto, 
  
  /// SMS/Text message links.
  sms, 
  
  /// WhatsApp chat links.
  whatsapp, 
  
  /// Telephone/Dialpad links.
  tel, 
  
  /// Map/Geo-navigation links.
  maps 
}
