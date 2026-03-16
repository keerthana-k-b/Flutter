import 'dart:io';

void main(){
  print("Enter a name:");
  String? name = stdin.readLineSync();
  int? age = int.parse(stdin.readLineSync()!);
  double? weight = double.parse(stdin.readLineSync()!); 
  print(name);
  print(age);
  print(weight);
}