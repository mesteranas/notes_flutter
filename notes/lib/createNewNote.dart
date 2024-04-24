import 'jsonControl.dart' as jsonControl;
import 'package:flutter/material.dart';
class CreateOrEditNewNote extends StatelessWidget{
  final TextEditingController name=TextEditingController();
  final TextEditingController noteContent=TextEditingController();
  final String title;
  final content;
  List<Map<String,String>> notes=[{"name":"no notes fownd!","content":"","date":""}];
  CreateOrEditNewNote(this.title,this.content);

    void initState(){
  updateNotes();
  }
  Future <void> updateNotes() async{
    final result=await jsonControl.get();
      notes=result;

  }

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
          notes.add({"name":name.text,"content":noteContent.text,"date":formatDate});
          jsonControl.save(notes);
          Navigator.pop(context);
        }, child: Text("done"))
      ],) ,),
    );
  }
}