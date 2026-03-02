// Write a Dart program to perform the following operations on an array:
// Sum of elements
// Maximum element
// Minimum element
// Count even and odd numbers

import 'dart:io';

void main(){
  int even =0;
  int odd=0;
  List numbers =[];
  print("Enter the limit: ");
  int? n = int.parse(stdin.readLineSync()!);
  for(int i = 0; i <= n; i++){
    int? num = int.parse(stdin.readLineSync()!);
    numbers.add(num);
  }
  print(numbers);
  int min=numbers[0];
  int max=numbers[0];
  int sum = numbers.reduce((a,b) => a+ b);
  for(int i = 0; i<= n; i++){
    if(numbers[i] % 2 == 0){
      even++;
    }else{
      odd++;
    }
    if(numbers[i]>max){
      max = numbers[i];
    }
    if(numbers[i]<min){
      min = numbers[i];
    }
  }
  print("Sum of elements: $sum");
  print("Number of even numbers: $even");
  print("Number of odd numbers: $odd");
  print("Maximum: $max");
  print("Minimum: $min");
}