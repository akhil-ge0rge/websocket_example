import 'package:flutter/material.dart';

import '../../data/response/app_response.dart';
import '../../data/response/status.dart';

mixin AppStateHandleMixin<T> on ChangeNotifier {
  ApiResponse<T>? _appResponse;

  set setAppResponse(ApiResponse<T>? appResponse) {
    _appResponse = appResponse;
    if (appResponse == null) return;
    notifyListeners();
  }

  ApiResponse<T>? get appResponse => _appResponse;

  // Api respose state with out data and message
  Status? _appLoadingStatus;

  set setAppStatusLoading(Status? status) {
    _appLoadingStatus = status;
    if (status == null) return;
    notifyListeners();
  }

  Status? get appLoadingStatus => _appLoadingStatus;

  Status? _appLoadingStatus1;

  set setAppStatusLoading1(Status? status) {
    _appLoadingStatus1 = status;
    if (status == null) return;
    notifyListeners();
  }

  Status? get appLoadingStatus1 => _appLoadingStatus1;
}
