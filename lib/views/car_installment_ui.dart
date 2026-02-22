import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class CarInstallmentUi extends StatefulWidget {
  const CarInstallmentUi({super.key});

  @override
  State<CarInstallmentUi> createState() => _CarInstallmentUiState();
}

class _CarInstallmentUiState extends State<CarInstallmentUi> {
  int selectedValue = 10;
  int selectedMonths = 24;
  final List<int> monthOptions = [24, 36, 48, 60, 72];

  final TextEditingController carPrice = TextEditingController();
  final TextEditingController yearVat = TextEditingController();

  double monthlyPayment = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          'CI Calculator',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.08,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 241, 205, 0),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 40),
          child: Center(
            child: Column(
              children: [
                Text(
                  'คำนวณค่างวดรถยนต์',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.055,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 230,
                  height: 150,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 255, 255, 255),
                    border: Border.all(
                      color: const Color.fromARGB(255, 255, 202, 30),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/car_pic.jpg',
                      width: 1000,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('ราคารถ (บาท)'),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: carPrice,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: '0.00',
                    hintStyle: TextStyle(
                      color: Colors.grey.withValues(alpha: 0.9),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'จำนวนเงินดาวน์ (%)',
                  ),
                ),
                Row(
                  children: [10, 20, 30, 40, 50].map((int value) {
                    return Row(
                      mainAxisSize: MainAxisSize
                          .min, // ให้ Row ตัวในกินพื้นที่เท่าที่จำเป็น
                      children: [
                        Radio<int>(
                          value: value,
                          groupValue: selectedValue,
                          onChanged: (int? newValue) {
                            setState(() {
                              selectedValue = newValue!;
                            });
                          },
                        ),
                        Text("$value"),
                        const SizedBox(width: 8),
                      ],
                    ); // ห้ามใส่ ; ตรงนี้
                  }).toList(), // ต้องมี .toList() เพื่อแปลง map ให้กลับเป็นรายการ Widget
                ),
                SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ระยะเวลาผ่อน (เดือน)',
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                DropdownButtonFormField<int>(
                  value: selectedMonths,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0), // ความมนของกรอบ
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedMonths = newValue!;
                    });
                  },
                  items: [24, 36, 48, 60, 72].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text('$value เดือน'),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('อัตราดอกเบี้ย (%/ปี)')),
                SizedBox(
                    height: 5,
                ),
                TextField(
                  controller: yearVat,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: '0.00',
                    hintStyle: TextStyle(
                      color: Colors.grey.withValues(alpha: 0.9),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if(carPrice.text.isEmpty || yearVat.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }
                          double cp = double.parse(carPrice.text);
                          double yv = double.parse(yearVat.text);

                          setState(() {
                            double totalPrice = cp - (cp * selectedValue / 100);
                            double allVat = (totalPrice * yv / 100) * (selectedMonths / 12);
                            monthlyPayment = ((totalPrice + allVat) / selectedMonths) * 1.07;
                          });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        backgroundColor: Color.fromARGB(255, 22, 175, 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        'คำนวณ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 32,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          carPrice.clear();
                          yearVat.clear();
                          monthlyPayment = 0.0;
                          selectedValue = 10;
                          selectedMonths = 24;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 43, vertical: 20),
                        backgroundColor: Color.fromARGB(255, 255, 0, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        'ยกเลิก',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 220, 235, 218),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: const Color.fromARGB(255, 22, 175, 16),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'ค่างวดรถต่อเดือนเป็นเงิน',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          NumberFormat('#,##0.00').format(monthlyPayment),
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 255, 0, 0),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'บาทต่อเดือน',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
