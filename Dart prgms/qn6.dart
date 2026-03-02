//Write a Dart program to extract all numbers from a mixed alphanumeric string and calculate their sum

import 'dart:io';

// void main() {
//    final input = stdin.readLineSync();
//    if (input == null || input.isEmpty){
//     print(("Invalid input!"));
//    }
//   final sum = RegExp(r'\d+')
//       .allMatches(input!)
//       .map((match) => int.parse(match.group(0)!))
//       .fold<int>(0, (total, number) => total + number);

//   print("Total Sum: $sum");
// }

void main(){
  int sum = 0;
  String? input = stdin.readLineSync()!;
  String temp = '';
  for(int i = 0; i < input.length; i++){
    if(input[i] .contains(RegExp('[0-9]'))){
      temp += input[i];
    }else if( temp.isNotEmpty) {
      sum += int.parse(temp); //toInt kandillel int.parse
      temp = '';  //variable reset
    }

  }
  print("Sum = $sum");
}