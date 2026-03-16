void main(){
  int a = 0;
  int b = 1;
  int n = 5;
  int? next ;
  print("Fibonacci Series ");
  for (int i = 1; i <= n; i++){
    print(a);
    next = a + b ;
    a = b ;
    b = next ;
  }
}