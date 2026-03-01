import 'dart:io';

void main(){
  var choice;
  print("Enter a mark: ");
  int? mark = int.parse(stdin.readLineSync()!);
  if (mark >= 90){
     choice = 1;
  }else if (mark >= 80){
     choice = 2;
  }else if(mark >=70){
     choice = 3;
  }else if(mark >= 60){
     choice = 4;
  }else{
     choice = 5; 
  }

  switch (choice){
    case 1:
     print("Grade A");
     break;
    case 2:
     print("Grade B");
     break;
    case 3:
     print("Grade C");
     break;
    case 4:
     print("Grade D");
     break;
    default:
     print("Fail");
  }
}