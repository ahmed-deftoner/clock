import 'package:clock/Clock.dart';
import 'package:clock/enums.dart';
import 'package:clock/list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'menu_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<Menu_info>(
        create: (context) => Menu_info(menu_type.clock),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    var now= DateTime.now();
    var formatime=DateFormat('HH:mm').format(now);
    var formatdate=DateFormat('EEE, d MMM').format(now);
    var timezone=now.timeZoneOffset.toString().split('.').first;
    var offsign='';
    if(!timezone.startsWith('-'))
      offsign='+';


    return Scaffold(
      backgroundColor: Color(0xFF444974),
        body: Row(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: menuitems.map((currentmenu) => buildbutton(currentmenu)).toList()
            ),
            VerticalDivider(
              color: Colors.white54,
              width: 1,
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SafeArea(
                   child:Text(
                    'Clock',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24
                    ),
                  ),
                  ),
                  SizedBox(height: 32),
                  Text(
                    formatime,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 64
                    ),
                  ),
                  Text(
                    formatdate,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24
                    ),
                  ),
                  SizedBox(height: 25,),
                  Clock(size: MediaQuery.of(context).size.height/3),
                  SizedBox(height: 20,),
                  Text(
                    'Timezone',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.language,
                        color: Colors.white,
                      ),
                      Text(
                        '  UTC '+offsign+timezone,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
    );
  }

  Widget buildbutton(Menu_info currentmenu){
    return Consumer<Menu_info>
      (builder: (BuildContext context, Menu_info value,Widget child){
         return FlatButton(
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.only(topRight: Radius.circular(32.0))
           ),
             padding: const EdgeInsets.symmetric(vertical: 16.0),
             color: currentmenu.menu==value.menu
                 ?Color(0xFF1B3766): Colors.transparent,
             onPressed: (){
               var menuinfo=Provider.of<Menu_info>(context,listen: false);
               menuinfo.update_menu(currentmenu);
             },
             child: Column(
               children: <Widget>[
//Image.asset(image),
                 SizedBox(height: 16),
                 Text(
                   currentmenu.title,
                   style: TextStyle(
                       color: Colors.white,
                       fontSize: 14
                   ),
                 )
               ],
             )
         );
    });
  }
}

