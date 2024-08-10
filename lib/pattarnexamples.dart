
import 'dart:io';
main(){

  pattern(4);
 // patterntwo(5);
  patternThree(5);
  patternFour(5);
}

void pattern(int n) {
  // Outer loop for rows
  for (int row = 1; row <= n; row++) {
    // Inner loop for columns
    for (int col = 1; col <= row; col++) {
      stdout.write("* ");
    }
    stdout.writeln(); // Line break after each row
  }
}


/*void patterntwo(int n){
   for(int row=1;row<=n;row++){
     for(int col=1;col<=n;col++){
       stdout.write("*");
     }
     stdout.writeln();
   }
}*/


void patternThree(int n){
  for(int row=1;row<=n;row++){
    for(int col=5;col>=row;col--){
      stdout.write("*");
    }
    stdout.writeln();
  }
}


void patternFour(int n){
  for(int row=1;row<=n;row++){
    for(int col=1;col<=row;col++){
      stdout.write(col);
    }
    stdout.writeln();
  }
}