//Develop a student grading system that accepts marks, calculates grade, and handles invalid input.

import 'dart:io';

void main(){
    print("Enter Name of student: ");
    String? name = stdin.readLineSync();
    //print("Enter Mark of Maths: ");
    //int? mark1 = int.parse(stdin.readLineSync()!);
    //print("Enter Mark of Phy: ");
    //int? mark2 = int.parse(stdin.readLineSync()!);
    //print("Enter Mark of Che: ");
    //int? mark3 = int.parse(stdin.readLineSync()!);
    //print("Enter Mark of Bio: ");
    //int? mark4 = int.parse(stdin.readLineSync()!);
    //print("Enter Mark of Eng: ");
    //int? mark5 = int.parse(stdin.readLineSync()!);
    //double percent =(mark1+ mark2+mark3+mark4+mark5)/500*100;
    //print("Percentage = $percent %");
  
    int total = 0;
    print("Enter number of subjects: ");
    List marks=[];
    int? n = int.parse(stdin.readLineSync()!);
    for(int i=1 ;i <= n; i++){
      print("Enter mark$i : ");
      int? mark = int.parse(stdin.readLineSync()!);
      marks.add(mark);
      total += mark;
      
    }
    print("Student name: $name");
    print("Total Marks obtained = $total");
    double percent = (total/(n*100))*100;
    print("Percenrage = percent%");
    if(percent >= 90){
      print("Grade A");
    }else if(percent >= 80){
      print("Grade B");
    }else if(percent >= 70){
      print("Grade C");
    }else if(percent >= 60){
      print("Grade D");
    }else{
      print("Fail ");
    }
  
}