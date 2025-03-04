import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:restaurant_user/app/constants/app_enums.dart';
import 'package:restaurant_user/app/data/user_data.dart';

import '../data/service_data.dart';

class FirestoreService extends GetxService {
  static FirestoreService get to => Get.find();

  static const String _usersCollection = 'users';
  static const String _serviceCollection = 'services';

  Future<void> createUser() async {
    User user = FirebaseAuth.instance.currentUser!;

    UserData userData = UserData(
      name: user.displayName ?? '',
      email: user.email ?? '',
      photoUrl: user.photoURL ?? '',
      phoneNumber: user.phoneNumber ?? '',
      uid: user.uid,
      userType: UserType.user,
    );

    await FirebaseFirestore.instance
        .collection(_usersCollection)
        .doc(user.uid)
        .set(userData.toMap());
  }

  Future<void> requestForService({required String serviceName}) async {
    String serviceKey =
        FirebaseFirestore.instance.collection(_serviceCollection).doc().id;

    ServiceData serviceData = ServiceData(
      serviceName: serviceName,
      serviceId: serviceKey,
      requestedUserId: FirebaseAuth.instance.currentUser!.uid,
      serviceStatus: ServiceStatus.pending.name,
    );

    return FirebaseFirestore.instance
        .collection(_serviceCollection)
        .doc(serviceKey)
        .set(serviceData.toMap());
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getRealtimeService(
      {required String serviceId}) {
    return FirebaseFirestore.instance
        .collection(_serviceCollection)
        .doc(serviceId)
        .snapshots();
  }
}
