import 'createNewNote.dart';
import 'jsonControl.dart'as jsonControl;
import 'package:http/http.dart' as http;
import 'viewText.dart';
import 'app.dart';
import 'contectUs.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {

  runApp(const test());
}
class test extends StatefulWidget{
  const test({Key?key}):super(key:key);
  @override
  State<test> createState()=>_test();
}
class _test extends State<test>{
  List<Map<String,String>> notes=[];
  void initState(){
    super.initState();
  updateNotes();
  }
  Future <void> updateNotes() async{
    final result=await jsonControl.get();
    setState(() {
      notes=result;
    });
  }
  @override

  Widget build(BuildContext context){
    return MaterialApp(
      title: App.name,
      themeMode: ThemeMode.system,
      home:Builder(builder:(context) 
    =>Scaffold(
      appBar:AppBar(
        title: const Text(App.name),), 
        drawer: Drawer(
          child:ListView(children: [
          DrawerHeader(child: Text("navigation menu")),
          ListTile(title: Text("contect us"),onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ContectUsDialog()));
          },),
          ListTile(title: Text("donate"),onTap: (){
            launch("https://www.paypal.me/AMohammed231");
          },),
  ListTile(title: Text("visite project on github"),onTap: (){
    launch("https://github.com/mesteranas/"+App.appName);
  },),
  ListTile(title: Text("license"),onTap: ()async{
    String result;
    try{
    http.Response r=await http.get(Uri.parse("https://raw.githubusercontent.com/mesteranas/" + App.appName + "/main/LICENSE"));
    if ((r.statusCode==200)) {
      result=r.body;
    }else{
      result="error";
    }
    }catch(error){
      result="error";
    }
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewText("license", result)));
  },),
  ListTile(title: Text("about"),onTap: (){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(title: Text("about "+App.name),content:Center(child:Column(children: [
        ListTile(title: Text("version: " + App.version.toString())),
        ListTile(title:Text("developer: mesteranas")),
        ListTile(title:Text("description:" + App.description))
      ],) ,));
    });
  },)
        ],) ,),
        body:Container(alignment: Alignment.center
        ,child: Column(children: [const  Text("this app is created by mesteranas"),
        ElevatedButton(onPressed:() async{
          await Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateOrEditNewNote("", "")));
          await updateNotes();
        }, child: Text("create new note")),
          for (var item in notes)
          ListTile(title: Text(item["name"]??"note error"),
          onTap:() {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewText(item["name"]??"","date:${item["date"]??""} \n ${item["content"]??""}")));
          },)
    ])),)));
  }
}
