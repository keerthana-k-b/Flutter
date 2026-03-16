import 'dart:io';

void main(){
    print("Enter age: ");
  int? age = int.parse(stdin.readLineSync()!);

  if (age >= 18){                            //if
    print("Eligible for vote");
  }

 print("Enter mark: ");
  int? mark = int.parse(stdin.readLineSync()!);
 
  if(mark >= 45 ){                            //if-else
    print("pass");
  }else{
    print("Fail");
  }

  print("Enter marks: ");

  int? grade = int.parse(stdin.readLineSync()!);
 

if (grade >= 90) {                             //if–else if–else
  print("Grade A");
} else if (grade >= 75) {
  print("Grade B");
} else if (grade >= 50) {
  print("Grade C");
} else {
  print("Fail");
}
 
bool id = true;

if (age >= 18) {                       //nested-if
  if (id == true) {
    print("Entry allowed");
  }
}
  
//short way   - ternary operator

print("Enter a number: ");
int? num = int.parse(stdin.readLineSync()!);
String result = num % 2 == 0 ? "Even" : "Odd";
print(result);

}