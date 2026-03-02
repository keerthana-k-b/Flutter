//. Create a banking system program that supports deposit, withdrawal, and balance checking using keyboard input.

import 'dart:io';

void main(){
  
  print("Enter Name: ");
  String? name = stdin.readLineSync();
  print("Account Number: ");
  int? accno = int.parse(stdin.readLineSync()!);
  int choice;
  double balance = 0;


  do{
     print("Enter your choice: ");
      choice = int.parse(stdin.readLineSync()!);
    print("1.Deposit \n2.Withdrawal \n3.Balance \n4.Exit");
    
    switch(choice)  {
      case 1:
        print("Enter the amount: ");
        double? depo = double.parse(stdin.readLineSync()!);
        balance += depo;
        print(depo);
        break;
      case 2:
        print("Enter amount:");
        double? withdraw = double.parse(stdin.readLineSync()!);
        print("Withdrawal Successful");
        balance -= withdraw;
        break;
      case 3:
        print("Balance :$balance");
        break;
      case 4:
        break;
      default:
      print("Invalid");
      
    }
  }while(choice!=4);
    
}