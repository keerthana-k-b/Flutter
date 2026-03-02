// Write a Dart program to calculate the electricity bill based on the number of units consumed in kWh.

// The program should:

// Accept the number of units consumed (in kWh) from the user

// Use switch–case to apply the rate slabs

// Display the total electricity bill

// Rate slabs:

// 0–100 units → ₹1.5 per unit

// 101–200 units → ₹2.5 per unit

// Above 200 units → ₹4.0 per unit

import 'dart:io';

void main(){
  double? unit = double.parse(stdin.readLineSync()!);
  double bill=0;
  if(unit <= 100 ){
    bill = unit * 1.5; 
  }else if( unit <= 200){
    bill = (100 * 1.5) + ((unit - 100) * 2.5);
  }else{
    bill = (100 * 1.5)  + (100  * 2.5 ) + (unit - 200) * 4;
  }
  print(bill);
}

