import 'package:calculator/ui/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String userQn = '10+10';
  String userAns = '20';

  final List<String> btn = [
    'C','DL','*','%',
    '7','8','9','-',
    '4','5','6','+',
    '1','2','3','/',
    'PR','0','.','=',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: [
           Container(
             height: 250,
            child: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 55,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          userQn,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 45,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userAns,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 30,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child:Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                  color: Colors.white
                ),
                //alignment: Alignment.center,
                child: GridView.builder(
                  itemCount: btn.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                    itemBuilder: (context, index){
                    if(index == 0){
                      //Clear Button
                      return Buttons(
                          buttonTap: (){
                            setState(() {
                              userQn = '';
                              userAns ='';
                            });
                          },
                          buttonText: btn[index],
                          color:Colors.green,
                          textColor: Colors.white
                      );
                    } else if(index == 1){
                      //Single delete button
                      return Buttons(
                          buttonTap: (){
                            setState(() {
                              userQn = userQn.substring(0,userQn.length - 1);
                            });
                          },
                          buttonText: btn[index],
                          color: Colors.red,
                          textColor: Colors.white
                      );
                    }else if(index == btn.length-1){
                      //Equal button
                      return Buttons(
                          buttonTap: (){
                            setState(() {
                              if(userAns != ''){
                                userQn = userAns;
                                userAns = '';
                              }
                            });
                          },
                          buttonText: btn[index],
                          color: isOperator(btn[index])? Colors.deepPurple : Colors.deepPurple[50],
                          textColor: isOperator(btn[index])? Colors.white : Colors.deepPurple
                      );
                    }
                    else{
                      //Default button
                      return Buttons(
                          buttonTap: (){
                            setState(() {
                              userQn += btn[index];
                            });
                            onEqual();
                          },
                          buttonText: btn[index],
                          color: isOperator(btn[index])? Colors.deepPurple : Colors.deepPurple[50],
                          textColor: isOperator(btn[index])? Colors.white : Colors.deepPurple
                      );
                    }

                  }),
              )
          )
        ],
      ),
    );
  }

  bool isOperator(String x){
   if(x == '*' || x == '%'||x == '-'||x == '+'||x == '/'||x == '='){
     return true;
   }else{
     return false;
   }
  }

  void onEqual(){
    String finalQuestion = userQn;
    Parser p =Parser();
    Expression exp = p.parse(finalQuestion);
    double evl = exp.evaluate(EvaluationType.REAL, ContextModel());
    setState(() {
      userAns = evl.toString();
    });
  }
}
