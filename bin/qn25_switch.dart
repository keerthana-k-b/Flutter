//. Create a command-line calculator that supports multiple operations in one execution.

import 'dart:io';

void main(){
  while(true){
    print("Enter a number: ");
    String? a = stdin.readLineSync();
    if( a == null){
      continue;
    }
    if(a.toLowerCase() == 'exit'){
      break;
    }
    print("Enter another number: ");
    String? b = stdin.readLineSync()!;
    print("Enter your choice: ");
    String? op = stdin.readLineSync();
    int? c = int.tryParse(a)!;
    int? d = int.tryParse(b)!;
    switch(op) {
      case '+' :
      int sum = c + d;
      print("Sum = $sum");
      case '-' :
      int sub = c - d;
      print("Difference = $sub");
      case '*' :
      int mul = c * d;
      print("Product = $mul");
      case '/' :
      int div = c ~/ d;
      print("Division = $div");
      default:
        print("Invalid choice");

    }
  }
}