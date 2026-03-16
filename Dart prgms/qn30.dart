//Write a Dart program to calculate net salary of an employee.

// Rules:

// Basic salary is given as input
// HRA = 20% of basic salary
// DA = 10% of basic salary
// Net Salary = Basic + HRA + DA

import 'dart:io';

void main(){
  print("Enter basic salary: ");
  double? salary = double.parse(stdin.readLineSync()!);
  double HRA = salary * 20/100;
  print("HRA = $HRA");
  double DA = salary * 10/100;
  print("DA = $DA");
  double NetSalary = salary + HRA + DA;
  print("NetSalary = $NetSalary");
}