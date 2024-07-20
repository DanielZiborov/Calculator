import 'package:flutter/material.dart';

void main() => runApp(const  MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator()
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  Widget calcButton(String btnTxt, Color btnColor, Color txtColor) {
  return ElevatedButton(
    onPressed: () {
      setState(() {
        calculation(btnTxt);
      });
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: btnColor, 
      foregroundColor: Colors.blue,
      shape: const CircleBorder(), 
      padding: const EdgeInsets.all(10), 
    ),
    child: Text(
      btnTxt,
      style: TextStyle(
        fontSize: 30,
        color: txtColor
      ),
    )
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.black,
      appBar: AppBar(
        title: const Text(
          "Calculator",
          style: TextStyle(
            color: Colors.white,
          )
        ),
        backgroundColor: Colors.black
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment:  MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child:  Text(
                    text,
                    textAlign: TextAlign.left,
                    style:  const TextStyle(
                      color: Colors.white,
                      fontSize: 70,
                    ),
            
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //buttons 
                calcButton("AC",Colors.grey,Colors.black),
                calcButton("+/-", Colors.grey,Colors.black),
                calcButton("%", Colors.grey,Colors.black),
                calcButton("/", Colors.amber,Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //buttons 
                calcButton("7",const Color.fromARGB(255, 65, 59, 59),Colors.white),
                calcButton("8",const Color.fromARGB(255, 65, 59, 59),Colors.white),
                calcButton("9", const Color.fromARGB(255, 65, 59, 59),Colors.white),
                calcButton("x", Colors.amber,Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //buttons 
                calcButton("4",const Color.fromARGB(255, 65, 59, 59),Colors.white),
                calcButton("5", const Color.fromARGB(255, 65, 59, 59),Colors.white),
                calcButton("6", const Color.fromARGB(255, 65, 59, 59),Colors.white),
                calcButton("-", Colors.amber,Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //buttons 
                calcButton("1",const Color.fromARGB(255, 65, 59, 59),Colors.white),
                calcButton("2", const Color.fromARGB(255, 65, 59, 59),Colors.white),
                calcButton("3", const Color.fromARGB(255, 65, 59, 59),Colors.white),
                calcButton("+", Colors.amber,Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed:(){
                    setState(() {
                      calculation("0");
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 65, 59, 59), 
                    foregroundColor: Colors.blue,
                    shape: const StadiumBorder(), 
                    padding: const EdgeInsets.fromLTRB(34, 20, 128, 20), 
                  ),
                  child:  const Text(
                    '0',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                    )
                  ),
                ),
                calcButton(".", const Color.fromARGB(255, 65, 59, 59),Colors.white),
                calcButton("=", Colors.amber,Colors.white),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}

//Calculator logic

double numOne = 0;
double numTwo = 0;
String oper = '';

String text = '0';
bool stay = false;
bool stayResult = false;
int k=0;

void calculation(btnTxt) {
  //AC
  if(btnTxt == "AC"){
    numOne = 0;
    numTwo = 0;
    oper = '';

    text = '0';
    stay = false;

    k=0;

    return;
  }

  //после первого вычисления(т.е. когда было сделано первое =)
  if(stayResult){
    if(isNum(btnTxt) || btnTxt=='.'){
      text = btnTxt;
      k=0;
    }
    else if(isOper(btnTxt) || btnTxt=='.'){
      text += btnTxt;
      k=0;
    }
    stayResult = false;
    return;
  }

  //проверка на допустимость "."
  if(btnTxt=='.'){
    if(isOper(text[text.length-1]) || text.contains('.')){
      return;
    }
  }

  //если знак операции уже был а сейчас уже число 
  if(isNum(btnTxt) && stay){
    stay=false;
  }

  //если знак операции
  if(isOper(btnTxt)){
    stay = true;
    k++;
  }
  if(stay && k!=1 ){
    text = text.substring(0,text.length-1);
  }
  
  //начальная точка присвоение
  if(text=='0'){
    if(btnTxt == '.' || isOper(btnTxt)){
      text+=btnTxt;
    }
    else{
      text = btnTxt;
    }
    return;
  }
  
  //добавление к строке
  text+=btnTxt;

  //если знак равенства 
  if(btnTxt == '='){
    List<String> strList = splitNumbers(text);
    numOne = double.parse(strList[0]);
    String str = strList[1];
    str = str.substring(0,str.length - 1);
    numTwo = double.parse(str);
    switch(oper){
      case '+':
        add();
        break;
      case '-':
        sub();
        break;
      case 'x':
        mul();
        break;
      default:
        div();
    }
    stayResult = true;
  }
}

void add(){
  double result = numOne + numTwo;
  text = result.toString();
}

void sub(){
  double result = numOne - numTwo;
  text = result.toString();
}

void div(){
  double result = numOne / numTwo;
  text = result.toString();
}

void mul(){
  double result = numOne * numTwo;
  text = result.toString();
}

bool isOper(String str){
  bool res = false;
  if(str=='+' || str=='-' || str=='x' || str=='/'){
    res = true;
  }
  return res;
}

bool isNum(String str){
  bool res = false;
  if(double.tryParse(str)!=null){
    res = true;
  }
  return res;
}

List<String> splitNumbers(String str){

  if(isTrue('+')){
    oper = '+';
  }
  if(isTrue('-')){
    oper = '-';
  }
  if(isTrue('/')){
    oper = '/';
  }
  if(isTrue('x')){
    oper = 'x';
  }
  return str.split(oper);
}

bool isTrue(String str){
  return text.split(str).length > 1;
}
