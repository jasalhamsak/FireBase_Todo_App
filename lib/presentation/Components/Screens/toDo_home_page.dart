import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedemo/Resources/Models/Task_model.dart';
import 'package:firebasedemo/Resources/services/Task_service.dart';
import 'package:firebasedemo/Resources/services/auth-service.dart';
import 'package:firebasedemo/presentation/Components/Screens/Add_Task_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {

  TaskService _taskService =TaskService();
  @override
  Widget build(BuildContext context) {
    final themedata= Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
          onPressed: (){
          Navigator.pushNamed(context, '/addtask');
          },
        child: Icon(Icons.add,color: Colors.white,),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Text("Hi",style: themedata.textTheme.displayMedium,),
                      SizedBox(width: 10,),
                      Text("Jayk",style: themedata.textTheme.displayMedium,),
                    ],
                  ),
                ),
                CircleAvatar(
                  child: IconButton(onPressed: (){
                    final user =FirebaseAuth.instance.currentUser;
                    AuthService().logout().then((value) {
                      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false,);
                    });



                    }, icon: Icon(Icons.logout)),
                )
              ],
            ),
            SizedBox(height: 15,),
            Text("Yours To-Dos",style: themedata.textTheme.displayMedium,),
            SizedBox(height: 15,),


            StreamBuilder<List<TaskModel>>(
                stream: _taskService.getAllTask(),
                builder: (context,snapshot){


                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  
                  
                  if(snapshot.hasError){
                    return Center(child: Text("some Error Occured",style: themedata.textTheme.displaySmall,),);
                  }


                  if(snapshot.hasData && snapshot.data!.length ==0){

                    return Center(child: Text("No task Added",style: themedata.textTheme.displaySmall,),);

                  }
                  

                  if(snapshot.hasData &&snapshot.data!.length!=0){

                    List<TaskModel> tasks =snapshot.data??[];

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount:snapshot.data!.length,
                      itemBuilder: (context, index) {


                        final _task = tasks[index];
                        print(_task);


                        return Card(
                          elevation: 5.0,
                          color: themedata.scaffoldBackgroundColor,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Icon(Icons.circle_outlined,color: Colors.white,),
                            ),
                            title: Text("${_task.title}",style: themedata.textTheme.displaySmall,),
                            subtitle: Text("${_task.body}",style: themedata.textTheme.displaySmall,),
                            trailing: Container(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(onPressed: (){
                                    
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddTaskVeiw(task: _task,),));
                                    
                                  }, icon: Icon(Icons.edit,color: Colors.teal,)),
                                  IconButton(onPressed: (){
                                    
                                    _taskService.deleteTask(_task.id);
                                  }, icon: Icon(Icons.delete,color: Colors.red,)),
                                ],
                              ),
                            ),
                          ),
                        );
                      },);
                  }


                  return Center(child: CircularProgressIndicator(),);
                })

          ],
        ),
      ),
    );
  }
}
