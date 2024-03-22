import 'package:untitled1/screen/register.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/screen/loginpage.dart';

class Welcomescreen extends StatefulWidget {
  static String r = 'welcomescreen';

  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation a;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
      //upperBound: 100.0,
      // lowerBound: 0.0
    );
    a = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
    controller.addListener(() {
      setState(() {});
      print(a.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.greenAccent.withOpacity((controller.value-0.0)/(100.0-0.0)),
      //opacity = (controller.value - lowerBound) / (upperBound - lowerBound)
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Image(
                    image: AssetImage('images/logo.png'),
                    height: a.value * 250,
                  ),
                ),
                /*Text(
                  "${(controller.value.toInt())}", //"${controller.value.toInt()}%",
                  style: TextStyle(fontSize: 45),
                )*/
              ],
            ),
            SizedBox(
              height: 20,
            ),
            buttonwidget("login","logo",(){Navigator.pushNamed(context,loginpage.l);},Colors.green),
            SizedBox(
              height: 20,
            ),
            Hero(
              tag: 'r',
              child: FilledButton(
                onPressed: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>registration()));
                  Navigator.pushNamed(context, registration.rg);
                },
                child: Text("Register"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.blueAccent)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class buttonwidget extends StatelessWidget {
  buttonwidget( this.title, this.ttag,this.pressed, this.color);
  final String title;
  final VoidCallback pressed;
  final String ttag;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Hero(
        tag: ttag,
        child: FilledButton(
          onPressed: pressed,
          child: Text("$title"),
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(color),
          ),
        ),
      ),
    );
  }
}
