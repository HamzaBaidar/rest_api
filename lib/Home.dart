import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Model/PostsModel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // jb jason ka structure ma array ka name naa diya ho to hamein ya procedure karna parta ha
 // hamara saara data is post list k andar save ho jae ga
  // jb hamein jason ka response ma array ka name nai milta to hamein ya saara process karna parta ha
  // r agar hamein response ma array name  milta ha to hamein just response ko show karwaana parta ha
  List<PostsModel> postlist=[];
  Future<List<PostsModel>> getPostApi() async{
    // yahan se api ka response aata ha jo hum is postsModel ko pass kartay han
    // phr hum postsModel k through is ko postList ma store kartay han
    final response= await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data= jsonDecode(response.body.toString());
    if(response.statusCode==200){
      //clear function is ko hot reload par list ko dobara reload nai honay deta
      postlist.clear();
      for (Map i in data){
        postlist.add(PostsModel.fromJson(i));
      }
      return postlist;
    }
    else{
      return postlist;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Column(
        children: [
      Expanded(
        child: FutureBuilder(
          // jaisay hi app run hoti ha to getPostApi call hota ha phr us ma future function wait kar raha hota ha jb tk usay response na milay
          // jb tk response nai milta hum user ko loading dikha rehay hotay han
            future:  getPostApi(),
            builder: (context,snapshot){
          if(!snapshot.hasData){
            return Text("Loading");
          }
          else{
            return ListView.builder(
                itemCount: postlist.length,
                itemBuilder: (context,index)
            {
              return Card(
                child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Title ",
                        style: TextStyle(
                        fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal
                      ),),
                      Text(postlist[index].title.toString(),style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),),
                      SizedBox(height: 5,),
                      Text("Description",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal
                        ),),
                      Text(postlist[index].body.toString()),

                    ],
                  ),
                ),
              );
            });
          }

        }),
      )
        ],
      ),
    );
  }
}
