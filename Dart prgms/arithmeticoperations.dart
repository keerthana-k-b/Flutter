import 'dart:io';
void main(){
  print("Enter a number: ");
  int? a = int.parse(stdin.readLineSync()!);
  print("Enter another number: ");
  int? b = int.parse(stdin.readLineSync()!);
  int sum = a + b;
  print("Sum = $sum");
  int sub = a - b;
  print("Difference = $sub");
  int mul = a * b;
  print("Product = $mul");
  double div = a / b;
  print("Division = $div");
  int mod = a % b;
  print("Modulus = $mod");
}