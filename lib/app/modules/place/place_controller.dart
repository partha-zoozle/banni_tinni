import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:banni_tinni/app/data/models/place_model.dart';
import 'package:banni_tinni/app/data/providers/place_provider.dart';

class PlaceController extends GetxController {
  late final PlaceProvider placeProvider;

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final googleMapsUrlController = TextEditingController();
  final placeIdController = TextEditingController();
  final descriptionController = TextEditingController();
  final remarksController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  final RxBool isSubmitting = false.obs;
  final int _pageSize = 10;

  late final PagingController<int, PlaceModel> pagingController;

  final RxList<String> foodCategories = <String>[].obs;
  final RxList<String> items = <String>[].obs;
  final RxList<String> images = <String>[].obs;

  @override
  void onInit() {
    placeProvider = Get.find<PlaceProvider>();
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    addressController.dispose();
    googleMapsUrlController.dispose();
    placeIdController.dispose();
    descriptionController.dispose();
    remarksController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    pagingController.dispose();
    super.onClose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final response = await placeProvider.getPlaces(
        page: pageKey,
        limit: _pageSize,
      );

      final isLastPage = response.results.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(response.results);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(response.results, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void refresh() {
    pagingController.refresh();
  }

  void addFoodCategory(String category) {
    if (category.isNotEmpty && !foodCategories.contains(category)) {
      foodCategories.add(category);
    }
  }

  void removeFoodCategory(String category) {
    foodCategories.remove(category);
  }

  void addItem(String item) {
    if (item.isNotEmpty && !items.contains(item)) {
      items.add(item);
    }
  }

  void removeItem(String item) {
    items.remove(item);
  }

  void addImage(String imageUrl) {
    if (imageUrl.isNotEmpty && !images.contains(imageUrl)) {
      images.add(imageUrl);
    }
  }

  void removeImage(String imageUrl) {
    images.remove(imageUrl);
  }

  Future<void> addPlace() async {
    if (nameController.text.isEmpty ||
        addressController.text.isEmpty ||
        googleMapsUrlController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        remarksController.text.isEmpty ||
        latitudeController.text.isEmpty ||
        longitudeController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all required fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isSubmitting.value = true;
      final place = PlaceModel(
        name: nameController.text,
        address: addressController.text,
        googleMapsUrl: googleMapsUrlController.text,
        placeId: placeIdController.text,
        description: descriptionController.text,
        remarks: remarksController.text,
        foodCategory: foodCategories,
        items: items,
        images: images,
        latitude: double.parse(latitudeController.text),
        longitude: double.parse(longitudeController.text),
      );

      final response = await placeProvider.addPlace(place);

      if (response.status.isOk) {
        _clearForm();
        Get.snackbar(
          'Success',
          'Place added successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        refresh();
      } else {
        throw Exception('Failed to add place');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add place',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  void _clearForm() {
    nameController.clear();
    addressController.clear();
    googleMapsUrlController.clear();
    placeIdController.clear();
    descriptionController.clear();
    remarksController.clear();
    latitudeController.clear();
    longitudeController.clear();
    foodCategories.clear();
    items.clear();
    images.clear();
  }
}
