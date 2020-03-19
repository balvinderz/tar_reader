import 'dart:io';
import 'dart:convert';
import 'dart:math';

final  NUL =utf8.encode("\0");
final BLOCKSIZE =512;
final RECORDSIZE = BLOCKSIZE*20;
final GNU_MAGIC = utf8.encode("ustar  \0");
final POSIX_MAGIC = utf8.encode("ustar\x0000");

void readFileAsync() async {
  String path  ="../test.tar.gz";
  File f = new File(path);
  final contents =await  f.readAsBytes();
  print(contents.length);
  int start=0;
  int offset =100;
  int end =start+offset;
  int i=0;
  int count =0;
  while(i<contents.length)
  {
    start = i;
    offset=100;
    end = start+offset;

    try{
      final subList = contents.sublist(i,i+512);
      int countZeroes =0;
      for(int j =0;j<512;j++)
        if(subList[j]==0)
            countZeroes+=1;
      if(countZeroes==512)
      {count+=1;
        i+=512;
        continue;
        
      }
      if(count==2)
      break;
      print("i is $i");
      if(utf8.decode(contents.sublist(i+257,i+257+6))=="ustar\x00")
      {
        var name = utf8.decode(contents.sublist(start,end));
      dynamic   size = utf8.decode(contents.sublist(i+124,i+124+12));
      var mode = utf8.decode(contents.sublist(i+100,i+100+8));
      dynamic  lastModified = utf8.decode(contents.sublist(i+136,i+136+12));
      lastModified = octToDecimal(int.parse(lastModified));
      dynamic linkedFile = utf8.decode(contents.sublist(i+157,i+157+100));
      dynamic fileType = utf8.decode(contents.sublist(i+156,i+156+1));
     // dynamic userName = utf8.decode(contents.sublist(i+297,i+297+32));
     size = octToDecimal(int.parse(size));
      print(name);
      print(mode);
      print(lastModified);
      print(linkedFile);
      print(fileType);
      print("file contents are : ");
      print(utf8.decode(contents.sublist(i+512,i+512+size)));
      }
      
    
      
      //print(userName);
    }
    catch(e)
    {
    }
    i+=512;
  }
  
}
int octToDecimal(int number)
  {
    int decimal =0;
      
      int power = 0;
      while(number!=0)
      {
        int lastDigit = number%10;
        number=number~/10;
        //print(t);
        decimal += lastDigit*pow(8, power);
        power++; 
      }
      return decimal;
  }