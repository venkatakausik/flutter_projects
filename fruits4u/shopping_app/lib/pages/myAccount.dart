import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/components/loading.dart';
import 'package:shoppingapp/db/users.dart';
import 'package:shoppingapp/pages/home.dart';
import 'package:shoppingapp/provider/user_provider.dart';
class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final FocusNode myFocusNode = FocusNode();
  String name;
  String email;
  String mobile;
  String photo;
  User user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    UserServices(uid: user.uid).getUserData().then((value){
      setState(() {
        name = value['name'];
        email = value['email'];
        mobile = value['mobile'];
        photo = value['picture'];
      });
    });
    return new Scaffold(
        appBar: AppBar(
          elevation: 0.2,
          backgroundColor: Colors.green[500],
          title: InkWell(
            onTap: (){Navigator.of(context).push(MaterialPageRoute(builder:(context)=>HomePage()));},
            child:Center(child: Text('My Account')),
          ),
          actions: <Widget>[
            new IconButton(
                icon: Icon(
                  Icons.update,
                  color: Colors.white,
                ),
                onPressed: () {
                  _showSettingsPanel(user.uid);
                }),
          ],
        ),
        body: (name==null && email == null && mobile==null)?Loading():new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    height: 250.0,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: new Stack(
                              fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    width: 140.0,
                                    height: 140.0,
                            child:Image.asset("images/as.png"),)
                              ],
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Personal Information',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Name',
                                        style: TextStyle(
                                            fontSize: 16.0,color:Colors.deepOrangeAccent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        name,
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Email ID',
                                        style: TextStyle(
                                            fontSize: 16.0,color:Colors.deepOrangeAccent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        email,
                                        style: TextStyle(
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Mobile',
                                        style: TextStyle(
                                            fontSize: 16.0,color:Colors.deepOrangeAccent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        mobile==null?"Mobile number not provided":mobile,
                                        style: TextStyle(
                                            fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }


  void _showSettingsPanel(String uid) {
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 60,vertical: 20),
        child:SettingsFrom(id: uid),
      );
    });
  }
}
class SettingsFrom extends StatefulWidget {
  String id;
  SettingsFrom({this.id});
  @override
  _SettingsFromState createState() => _SettingsFromState();
}

class _SettingsFromState extends State<SettingsFrom> {
  final _formKey = GlobalKey<FormState>();
  String mobile;
  String email;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: Column(
          children: <Widget>[
            Text("Update your info",style: TextStyle(fontSize: 18),),
            SizedBox(height: 20,),
            TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Mobile",
                icon: Icon(Icons.phone),
              ),
              validator: (val)=>
                val.isEmpty?'Please enter mobile number':val.length<10?'Enter a valid mobile number':null,
              onChanged: (val)=>setState(()=>mobile=val),
            ),
            SizedBox(height: 20,),
            RaisedButton(onPressed: ()async{
              if(_formKey.currentState.validate()){
                await UserServices(uid: widget.id).updateUserData(mobile);
                Navigator.pop(context);
              }
            },child: Text('Update'),color:Colors.green),
          ],
        ),
    );
  }
}
