//Program to count even, odd, positive, negative numbers from user input.

import 'dart:io';

void main(){
  int neg=0;
  int pos=0;
  int even=0;
  int odd=0;
  print("Enter limit:");
  int? n= int.parse(stdin.readLineSync()!);

  for(int i=1; i <= n; i++){
    int? num = int.parse(stdin.readLineSync()!);
    if( num % 2 == 0){
      print("Even");
      even++;
    }else{
      print("Odd");
      odd++;
    }
    if(num < 0){
      print("Negative");
      neg++;
    }else{
      print("Positive");
      pos++;
    }
  }
  print("Count of Even numbers = $even \nCount of Odd numbers = $odd \nCount of Negative numbers = $neg \nCount of Positive numbers = $pos");

}