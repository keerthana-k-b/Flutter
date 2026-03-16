import 'dart:io';

void main(){
  while(true){
    print("Enter a number:");
    String? a = stdin.readLineSync();
    
    if( a == null ){
      continue;
    }
    if(a.toLowerCase() == 'exit'){
      break;
    }
    print("Enter another number: ");
    String? b = stdin.readLineSync()!; //b null check chyunilla 
    print("Enter the operator: ");
    String? op=stdin.readLineSync();
    int c = int.parse(a);
    int d = int.parse(b);
    if(op == '+'){
      int add = c+d;
      print("Sum = $add");
    }else if(op == '-'){
      int sub = c - d;
      print("Difference = $sub");
    }else if(op == '*'){
      int mul = c * d;
      print("Product = $mul");
    }else if(op == '/'){
      int div = c ~/ d;
      print("Division = $div");
    }else{
      print("Invalid");
    }

  }

}