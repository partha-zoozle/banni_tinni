import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:banni_tinni/app/data/models/link_model.dart';
import 'package:banni_tinni/app/data/providers/link_provider.dart';

class LinkController extends GetxController {
  late final LinkProvider linkProvider;
  final urlController = TextEditingController();

  final RxBool isSubmitting = false.obs;
  final int _pageSize = 10;

  late final PagingController<int, LinkModel> pagingController;

  @override
  void onInit() {
    linkProvider = Get.find<LinkProvider>();
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.onInit();
  }

  @override
  void onClose() {
    urlController.dispose();
    pagingController.dispose();
    super.onClose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final response = await linkProvider.getLinks(
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
      if (!pagingController.itemList.isNull &&
          pagingController.itemList!.isNotEmpty) {
        Get.snackbar(
          'Error',
          'Failed to load more links. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
      pagingController.error = error;
    }
  }

  void refresh() {
    pagingController.refresh();
  }

  Future<void> addLink() async {
    final url = urlController.text.trim();
    if (url.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a URL',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!GetUtils.isURL(url)) {
      Get.snackbar(
        'Error',
        'Please enter a valid URL',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isSubmitting.value = true;
      final response = await linkProvider.addLink(url);

      if (response.status.isOk) {
        urlController.clear();
        await Future.delayed(const Duration(milliseconds: 500));
        pagingController.refresh();

        Get.snackbar(
          'Success',
          'Link added successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      } else {
        throw Exception('Failed to add link: ${response.statusText}');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add link. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isSubmitting.value = false;
    }
  }
}
