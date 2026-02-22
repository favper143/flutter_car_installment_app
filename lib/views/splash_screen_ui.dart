import 'package:flutter/material.dart';
import 'package:flutter_car_installment_app/views/car_installment_ui.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {

  void initState() {
    // delay 3 seconds and go to HomeUi cant back
    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  CarInstallmentUi(),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 205, 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/car_calculate.png',
              width: MediaQuery.of(context).size.width * 0.50,
              height: MediaQuery.of(context).size.width * 0.50,
              fit: BoxFit.cover,      
            ),
            SizedBox(
              height: 10),
            Text(
              'Car Installment ',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'คำนวณค่างวดรถยนต์',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.035,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20),
            CircularProgressIndicator(
              color: Colors.white,
            ),
            SizedBox(
              height: 20),
            Text(
              'Created by : fav per',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.02,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'version 1.0.0',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.02,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}