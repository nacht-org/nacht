class NotificationChannel {
  const NotificationChannel({
    required this.id,
    required this.name,
    required this.description,
  });

  final String id;
  final String name;
  final String description;

  static const NotificationChannel appUpdateCheck = NotificationChannel(
    id: 'appUpdateCheck',
    name: 'Update Check',
    description: 'Prompts to update when available',
  );
}
