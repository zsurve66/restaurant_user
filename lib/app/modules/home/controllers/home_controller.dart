import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_user/app/data/service_data.dart';
import 'package:restaurant_user/app/services/firestore_service.dart';

class HomeController extends GetxController {
  TextEditingController serviceController = TextEditingController();
  RxBool isLoading = false.obs;
  RxList<ServiceData> requestedServices = <ServiceData>[].obs;

  @override
  void onInit() {
    _initServices();
    fetchRequestedServices();
    super.onInit();
  }

  void _initServices() {
    Get.putAsync<FirestoreService>(() async => FirestoreService());
  }

  Future<void> sendServiceRequest() async {
    if (serviceController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter a service name',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    try {
      await FirestoreService.to
          .requestForService(serviceName: serviceController.text);
      Get.snackbar('Success', 'Service request sent: ${serviceController.text}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      serviceController.clear();
    } catch (e) {
      Get.snackbar('Error', 'Failed to send service request',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetches all services requested by the logged-in user
  void fetchRequestedServices() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('services')
        .where('requestedUserId', isEqualTo: userId)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      requestedServices.value = snapshot.docs.map((doc) {
        return ServiceData.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
