//Create a program that accepts a comma-separated list of integers from the keyboard and finds the sum, average, min, and max.

import 'dart:io';
void main(){
String? input = stdin.readLineSync();
List<int> numbers = input!.split(',').map((n)=> int.parse(n.trim())).toList();
int sum = numbers.reduce((a,b) => a + b);
print(sum);
int min = numbers.reduce((a,b)=> a <= b ? a : b);
print("Min $min");
int max = numbers.reduce((a,b)=> a >= b ? a : b);
print("Max $max");
double avg = sum / numbers.length;
print(avg);
}