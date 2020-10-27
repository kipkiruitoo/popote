import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huduma_popote/data/services.dart';
import 'package:huduma_popote/includes/appbar.dart';
import 'package:huduma_popote/includes/sidebar.dart';
import 'package:huduma_popote/models/service.dart';
class ServicesPage extends StatefulWidget {
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {

bool  _search = false;

  List<Service> services;
  @override
  void initState() {

    super.initState();
    services  =  getServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: _search ? searchField() : Image( image: AssetImage("assets/images/logo.png") ,width: 60,),
            actions: [
                IconButton(icon: Icon(Icons.search, color: Colors.black,), onPressed: (){
                  setState(() {
                    _search = ! _search;
                  });
                })
            ],
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Column(
                  children:[
                    Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: Text("Government Services", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,),
                        itemBuilder: (ctx, index){

                          return ServiceCard(
                              service: services[index]
                          );

                        },


                        itemCount: services.length,
                      ),
                    ),

                  ]
              ),
            ),
          )
        ],
      ),
    );
  }

 Widget searchField() {
    return Container(
      child: TextField(
        autofocus: false,
        style: TextStyle(color: Color(0xFFB40284A), fontSize: 18),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFFB40284A),
          ),
          hintStyle: TextStyle(
              color: Color(0xFFB40284A).withOpacity(0.5), fontSize: 12),
          hintText: "Start typing to Search",
          // enabledBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: Color(0xFFB40284A), width: 1),
          // ), //under line border, set OutlineInputBorder() for all side border
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFB40284A), width: 1),
          ), // focused border color
        ), //decoration for search input field
        onChanged: (value) {
          //update the value of query
          // getSuggestion(value); //start to get suggestion
        },  
      ),
    );
 }
}




class ServiceCard extends StatelessWidget {
  final Service service;
  ServiceCard({this.service});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10,10,10,0),
      height: 100,
      width: 150,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset("assets/images/${service.image}", width: 60,),
              Container(
                padding: EdgeInsets.all(20),
                child: Text(service.name),
              )
            ],
          ),

        ),
      ),
    );
  }
}
