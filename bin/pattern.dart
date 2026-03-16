import 'dart:io';
void main(){
  int rows = 6;
  for( int i = 1; i <= rows; i++ ){
     for(int j = 1 ; j <= i; j++ ){
        stdout.write("* "); //prints on same line
     }
   print(" ");
  }   
}