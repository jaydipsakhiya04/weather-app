import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:whether_app_netsofters/utils/app_constants.dart';
import '../controller/weather_controller.dart';

class WeatherView extends GetView<WeatherController> {
  String cityName;

  WeatherView({super.key, required this.cityName});

  double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }

  double windSpeedInKilometersPerHour(double windSpeed) {
    return windSpeed * 3.6;
  }

  String getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime = '${now.hour}:${now.minute} ${_getAmPm(now.hour)}';
    return formattedTime;
  }

  String _getAmPm(int hour) {
    return hour >= 12 ? 'PM' : 'AM';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<WeatherController>(
      init: WeatherController(),
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          await controller.getCityData(cityName: cityName);
        });
      },
      builder: (logic) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          body: Obx(() {
            String? main = controller.responseData.value.weather?[0].main;
            return Container(
              padding: EdgeInsets.all(22.r),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImages.imgBg2), fit: BoxFit.cover),
              ),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  50.h.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        main == "Clear"
                            ? AppImages.imgSun
                            : main == "Haze"
                                ? AppImages.imgHaze
                                : main == "Smoke"
                                    ? AppImages.imgSmoke
                                    : main == "Clouds"
                                        ? AppImages.imgCloud
                                        : main == "Mist"
                                            ? AppImages.imgHaze
                                            : AppImages.imgSun,
                        height: 100.r,
                        width: 100.r,
                      ),
                      10.w.horizontalSpace,
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                kelvinToCelsius(controller.responseData.value
                                                .main?.temp ??
                                            0)
                                        .toStringAsFixed(2) ??
                                    "",
                                style: TextStyle(
                                  fontSize: 60.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "°C",
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            getCurrentTime().toString(),
                            style: TextStyle(
                              fontSize: 35.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  10.h.verticalSpace,
                  Text(
                    "City : ${controller.responseData.value.name ?? ""}",
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  7.h.verticalSpace,
                  Text(
                    "Humidity : ${controller.responseData.value.main?.humidity ?? ""}%",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  5.h.verticalSpace,
                  Text(
                    "Wind : ${windSpeedInKilometersPerHour(controller.responseData.value.wind?.speed ?? 0).toStringAsFixed(2)} km/h",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  5.h.verticalSpace,
                  Text(
                    "Weather : ${controller.responseData.value.weather?[0].description ?? ""}",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
