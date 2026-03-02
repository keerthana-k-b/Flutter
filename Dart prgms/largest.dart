
import 'dart:io';
void main(){
  print("Enter 1st number: ");
  int? a = int.parse(stdin.readLineSync()!);
  print("Enter 2nd number: ");
  int? b = int.parse(stdin.readLineSync()!);
   if (a > b){
    print("$a is greater");
   }else if(b > a) {
    print("$b is greater");
   }else{
    print("$a and $b are equal");
   }
}