import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:whether_app_netsofters/controller/weather_controller.dart';
import 'package:whether_app_netsofters/utils/app_constants.dart';
import 'package:whether_app_netsofters/utils/logger.dart';
import 'package:whether_app_netsofters/view/weather_view.dart';

class EnterCityView extends StatefulWidget {
  const EnterCityView({Key? key}) : super(key: key);

  @override
  State<EnterCityView> createState() => _EnterCityViewState();
}

class _EnterCityViewState extends State<EnterCityView> {
  String? countryValue;
  String? stateValue;
  String? cityValue;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: 1 * h,
        width: 1 * w,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImages.imgBg1), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  "Welcome  ",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Please Select Your Location",
                  style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 40,
                ),
                CSCPicker(
                  layout: Layout.vertical,
                  onCountryChanged: (country) {
                    setState(() {
                      countryValue = country;
                    });
                  },
                  onStateChanged: (state) {
                    setState(() {
                      stateValue = state;
                    });
                  },
                  onCityChanged: (city) {
                    setState(() {
                      cityValue = city;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        onTap: () {
          logger("city ----->$cityValue");
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WeatherView(cityName: cityValue ?? "goa"),
              ));
        },
        child: Container(
          height: 50.h,
          width: 1.sw,
          margin: const EdgeInsets.all(20).r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8).r,
          ),
          child: Text(
            "Submit",
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black),
          ),
        ),
      ),
    );
  }
}
