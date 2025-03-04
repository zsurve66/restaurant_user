import 'dart:convert';

class ServiceData {
  final String serviceName;
  final String serviceId;
  final String requestedUserId;
  final String serviceStatus;
  String? assignedWaiterId;
  ServiceData({
    required this.serviceName,
    required this.serviceId,
    required this.requestedUserId,
    required this.serviceStatus,
    this.assignedWaiterId,
  });

  ServiceData copyWith({
    String? serviceName,
    String? serviceId,
    String? requestedUserId,
    String? serviceStatus,
    String? assignedWaiterId,
  }) {
    return ServiceData(
      serviceName: serviceName ?? this.serviceName,
      serviceId: serviceId ?? this.serviceId,
      requestedUserId: requestedUserId ?? this.requestedUserId,
      serviceStatus: serviceStatus ?? this.serviceStatus,
      assignedWaiterId: assignedWaiterId ?? this.assignedWaiterId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'serviceName': serviceName});
    result.addAll({'serviceId': serviceId});
    result.addAll({'requestedUserId': requestedUserId});
    result.addAll({'serviceStatus': serviceStatus});
    if (assignedWaiterId != null) {
      result.addAll({'assignedWaiterId': assignedWaiterId});
    }

    return result;
  }

  factory ServiceData.fromMap(Map<String, dynamic> map) {
    return ServiceData(
      serviceName: map['serviceName'] ?? '',
      serviceId: map['serviceId'] ?? '',
      requestedUserId: map['requestedUserId'] ?? '',
      serviceStatus: map['serviceStatus'] ?? '',
      assignedWaiterId: map['assignedWaiterId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceData.fromJson(String source) =>
      ServiceData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ServiceData(serviceName: $serviceName, serviceId: $serviceId, requestedUserId: $requestedUserId, serviceStatus: $serviceStatus, assignedWaiterId: $assignedWaiterId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServiceData &&
        other.serviceName == serviceName &&
        other.serviceId == serviceId &&
        other.requestedUserId == requestedUserId &&
        other.serviceStatus == serviceStatus &&
        other.assignedWaiterId == assignedWaiterId;
  }

  @override
  int get hashCode {
    return serviceName.hashCode ^
        serviceId.hashCode ^
        requestedUserId.hashCode ^
        serviceStatus.hashCode ^
        assignedWaiterId.hashCode;
  }
}
