import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class GetConnectHTTPClient extends GetConnect {
  final RxBool _networkUnAvailable = false.obs;
  bool _networkDialogVisible = false;

  @override
  void onInit() {
    super.onInit();
    httpClient.maxAuthRetries = 1;
    httpClient.defaultContentType = 'application/json';
    httpClient.followRedirects = true;

    // Initialize Network state listener
    ever(_networkUnAvailable, networkStatusChanged);
  }

  @override
  void onReady() {
    super.onReady();
    httpClient.addRequestModifier<dynamic>((request) => updateHeaders(request));
  }

  void networkStatusChanged(bool networkUnAvailable) {
    if (networkUnAvailable == true) {
      // TODO: handle network error
      _networkDialogVisible = true;
    } else {
      if (Get.isDialogOpen != null &&
          Get.isDialogOpen == true &&
          _networkDialogVisible == true) {
        // TODO: to close network dialog/page
      }
    }
  }

  // update request header for every network request call by default
  FutureOr<Request<dynamic>> updateHeaders(Request<dynamic> request) {
    request.headers['Accept'] = 'application/json';
    //TODO: Add request authentication
    return request;
  }

  Future<Response<dynamic>> handleNetworkError(
      Future<Response<dynamic>> response) {
    response.then((value) => {
          // Update the Network Availability status according to error returned in response
          if (value.hasError)
            {
              isConnected().then((isConnected) {
                _networkUnAvailable.value = (value.hasError &&
                    ((value.statusCode != null &&
                            value.statusCode == HttpStatus.requestTimeout) ||
                        (value.statusCode == null || !isConnected)));
              })
            }
        });

    return response;
  }

  Future<bool> shouldRetry() async {
    // return instantly if network is already available => should not retry
    if (_networkUnAvailable.value == false) return false;
    await Future.delayed(
        const Duration(seconds: 5)); // Wait for appropriate time
    return _networkUnAvailable.value;
  }

  Future<bool> isConnected() async {
    try {
      final Connectivity connectivity = Connectivity();
      final result = await connectivity.checkConnectivity();
      if (result != ConnectivityResult.none) {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
    return false;
  }
}
