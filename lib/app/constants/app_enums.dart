enum UserType {
  admin(name: 'Admin'),
  user(name: 'User'),
  waiter(name: 'Waiter');

  const UserType({required this.name});

  final String name;
}

enum ServiceStatus {
  pending(name: 'Pending'),
  assigned(name: 'Assigned'),
  completed(name: 'Completed');

  const ServiceStatus({required this.name});

  final String name;
}
