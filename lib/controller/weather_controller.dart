import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whether_app_netsofters/utils/base_controller.dart';
import 'package:whether_app_netsofters/utils/logger.dart';

import '../model/city_data_model.dart';

class WeatherController extends BaseController {
  static final Dio _dio = Dio();

  final String baseUrl = "https://api.openweathermap.org/data/2.5/weather?q";
  final String token = "enter your token here";

  Rx<CityDataModel> responseData = CityDataModel().obs;

  Future<void> getCityData({required String cityName}) async {
    try {
      showLoader();
      final response = await _dio.get("$baseUrl=$cityName&appid=$token");
      logger("$baseUrl/$cityName&appid=$token");

      if (response.statusCode == 200) {
        dismissLoader();
        responseData.value = cityDataModelFromJson(jsonEncode(response.data));
        responseData.refresh();
        logger("Response -----   ${responseData.value.name}");
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      showError(title: "Error", msg: e.toString());
    }
  }
}
