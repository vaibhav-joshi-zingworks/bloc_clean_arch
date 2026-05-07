/// Categories for classifying notification channels.
enum NotificationChannelType { 
  /// Standard notifications.
  general, 
  
  /// Promotional/Offer notifications.
  marketing, 
  
  /// Financial/Transactional notifications.
  transactions, 
  
  /// User-defined or system reminders.
  reminders, 
  
  /// Background tasks or download progress.
  progress, 
  
  /// 1-to-1 chat alerts.
  chat, 
  
  /// Group discussion alerts.
  groupChat 
}

/// Types of chat environments for messaging notifications.
enum ChatType { 
  /// One-on-one conversation.
  single, 
  
  /// Group-based conversation.
  group 
}
