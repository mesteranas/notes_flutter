import 'jsonControl.dart' as jsonControl;
import 'package:flutter/material.dart';
class CreateOrEditNewNote extends StatelessWidget{
  final TextEditingController name=TextEditingController();
  final TextEditingController noteContent=TextEditingController();
  final String title;
  final content;
  List<Map<String,String>> notes;
  CreateOrEditNewNote(this.title,this.content,this.notes);


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("new note"),
      ),
      body: Center(child:Column(children: [
        TextFormField(controller: name,decoration: InputDecoration(label: Text("title")),keyboardType: TextInputType.text,textInputAction: TextInputAction.next,),
        TextFormField(controller: noteContent,decoration: InputDecoration(label: Text("content")),keyboardType: TextInputType.multiline,textInputAction: TextInputAction.newline,maxLines: 10,),
        ElevatedButton(onPressed: (){
            DateTime now=DateTime.now();
            String formatDate="${now.day} / ${now.month} / ${now.year} ${now.hour} : ${now.minute} :${now.second} :${now.millisecond}";
          this.notes.add({"name":name.text,"content":noteContent.text,"date":formatDate});
          jsonControl.save(this.notes);
          Navigator.pop(context);
        }, child: Text("done"))
      ],) ,),
    );
  }
}