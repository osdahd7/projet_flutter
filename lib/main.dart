


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app10/pages/test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_app10/pages/test.dart' as rt;
import 'package:fluttertoast/fluttertoast.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static const routeName = '/extractArguments';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: MovieDetailsPage(/* title: 'Flutter Demo Home Page' */),
     // home: HomePage(/* title: 'Flutter Demo Home Page' */),
      home: new LoginPage(),
      routes: {
        ExtractArgumentsScreen.routeName: (context) => MovieDetailsPage(),
      },
    );
  }
}
class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute settings and cast
    // them as ScreenArguments.
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.message),
      ),
    );
  }
}
class ScreenArguments {
  final String title;
  final String message;
  final String id;

  ScreenArguments(this.title, this.message,this.id);
}
class Genre{
  final String genre;
  Genre({this.genre});
  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
    genre :json['name']
    );
  }

}
class Album {

  final int id;
  final String original_title;
  final String poster_path;
  final bool adult;
  final String release_date;
  final double vote_average;
  final String overview;

  Album({this.id, this.original_title, this.poster_path,this.adult, this.release_date, this.vote_average,this.overview});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      original_title: json['original_title'],
      poster_path: json['poster_path'],
       adult: json['adult'],
      release_date: json['release_date'],
      vote_average: json['vote_average'].toDouble() ,
      overview: json['overview'],
    );
  }
}

// ignore: camel_case_types
class Album_detail {

  final String adult;
  final String release_date;
  final String vote_average;
  final String overview;

  Album_detail({this.adult, this.release_date, this.vote_average,this.overview});

  factory Album_detail.fromJson(Map<String, dynamic> json) {

    return Album_detail(
      adult: json['adult'],
      release_date: json['release_date'],
      vote_average: json['vote_average'],
      overview: json['overview'],
    );
  }
}

 class MovieList {
   final List<Album> movies;
   MovieList({this.movies});
   factory MovieList.fromJson(List<dynamic> parsedJson)
   {
     List<Album> movies = new List<Album>();
     movies = parsedJson.map((i)=>Album.fromJson(i)).toList();
     return MovieList(
     movies: movies
     );
   }

 }
// ignore: camel_case_types
class Movie_detail{
  final List<Album_detail> movies;
  Movie_detail({this.movies});
  factory Movie_detail.fromJson(List<dynamic> parsedJson)
  {
    List<Album_detail> movies = new List<Album_detail>();
    movies = parsedJson.map((i)=>Album_detail.fromJson(i)).toList();
    return Movie_detail(
        movies: movies
    );
  }

}
class Genre_movies {
  final List<Genre_movies> movies;
  Genre_movies({this.movies});
  factory Genre_movies.fromJson(List<dynamic> parsedJson)
  {
    List<Genre_movies> movies = new List<Genre_movies>();
    movies = parsedJson.map((i)=>Genre_movies.fromJson(i)).toList();
    return Genre_movies(
        movies: movies
    );
  }

}
class HomePage extends StatelessWidget {

  Future<Album> futureAlbum;


  final List<String> popularMoviesImg = [
    'https://image.tmdb.org/t/p/original/2tfTE30QGr71g8XLUQefRdbbV4N.jpg',
    'https://image.tmdb.org/t/p/original/2tfTE30QGr71g8XLUQefRdbbV4N.jpg',
    'https://image.tmdb.org/t/p/original/2tfTE30QGr71g8XLUQefRdbbV4N.jpg',
  ];






  final response = http.get(
      'https://api.themoviedb.org/3/movie/76341?api_key=62feaff3d2cf094a340f530fbf25bde9');

  @override
  Widget build(BuildContext context) {


   



    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Container(
        margin: EdgeInsets.only(top: 45, bottom: 10, left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Popular movies",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 200,
                    child: FutureBuilder<MovieList>(
                      future: rt.fetchPhotos(),
                      builder: (BuildContext context,AsyncSnapshot<MovieList> snapshot){
                        if(snapshot.hasData){
                          final movies = snapshot.data.movies;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            return new GestureDetector(
                              onTap: (){
                                print(movies.elementAt(index).id);
                                //Navigator.push(context,MaterialPageRoute(builder: (context) => MovieDetailsPage  ()));
                                Navigator.pushNamed(
                                  context,
                                  ExtractArgumentsScreen.routeName,
                                  arguments: ScreenArguments(
                                    movies.elementAt(index).poster_path.toString(),
                                    movies.elementAt(index).original_title.toString(),
                                    movies.elementAt(index).id.toString(),
                                  ),
                                );
                              },
                              child: Container(
                                  child: Row(
                                    children: [
                                      Image.network("https://image.tmdb.org/t/p/w300"+movies.elementAt(index).poster_path),
                                      SizedBox(width: 20,)
                                    ],
                                  )
                              ),
                            );
                          },

                        );}
                        else if(snapshot.connectionState != ConnectionState.done)
                          {
                            return Center(child: CircularProgressIndicator());
                          }
                        return Container(child: Text("pas ok"),);
                      }
                    )

                  ),
                  // CarouselSlider(
                  //   options: CarouselOptions(height: 200.0, autoPlay: false, disableCenter: true, enableInfiniteScroll: false, aspectRatio: 2),
                  //   items: popularMoviesImg.map((imageUrl) {
                  //     return Builder(
                  //       builder: (BuildContext context) {
                  //         return Container(
                  //             height: 30,
                  //             margin: EdgeInsets.symmetric(horizontal: 5.0),
                  //             decoration: BoxDecoration(
                  //                 image: DecoContainer(
                  //                          width: 160.0,
                  //                          color: Colors.blue,
                  //                        ),
                  //                        Container(
                  //                          width: 160.0,
                  //                          color: Colors.green,
                  //                        ),
                  //                        Container(
                  //                          width: 160.0,
                  //                          color: Colors.yellow,
                  //                        ),
                  //                        Container(
                  //                          width: 160.0,
                  //                          color: Colors.orange,
                  //                        ),rationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover)
                  //             ),
                  //         );
                  //       },
                  //     );
                  //   }).toList(),
                  // )
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Popular movies",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          width: 160.0,
                          color: Colors.red,
                        ),
                        Container(
                          width: 160.0,
                          color: Colors.blue,
                        ),
                        Container(
                          width: 160.0,
                          color: Colors.green,
                        ),
                        Container(
                          width: 160.0,
                          color: Colors.yellow,
                        ),
                        Container(
                          width: 160.0,
                          color: Colors.orange,
                        ),
                      ],
                    ),
                  ),
                  // CarouselSlider(
                  //   options: CarouselOptions(height: 200.0, autoPlay: false, disableCenter: true, enableInfiniteScroll: false, aspectRatio: 2),
                  //   items: popularMoviesImg.map((imageUrl) {
                  //     return Builder(
                  //       builder: (BuildContext context) {
                  //         return Container(
                  //             height: 30,
                  //             margin: EdgeInsets.symmetric(horizontal: 5.0),
                  //             decoration: BoxDecoration(
                  //                 image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover)
                  //             ),
                  //         );
                  //       },
                  //     );
                  //   }).toList(),
                  // )
                ],
              ),
            ),

            Container(),
          ],
        ),
      ),
    );
  }
}

class MovieDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return FutureBuilder<Album>(
        future: rt.get_movie_details(args.id),
        builder: (BuildContext context,AsyncSnapshot<Album> snapshot) {

            if(snapshot.hasData) {
              return Stack(


                  children: <Widget>[

                    Image.network(
                      "https://image.tmdb.org/t/p/w300"+args.title,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),

                    Scaffold(

                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                          backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
                          leading: IconButton(

                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )),
                      body: Container(

                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [
                                    0,
                                    0.4
                                  ],
                                  colors: [
                                    Color.fromRGBO(0, 0, 0, 0.0),
                                    Color.fromRGBO(0, 0, 0, 0.9)
                                  ])),
                          margin:
                          EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(

                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          args.message,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5),
                                        Row(children: <Widget>[
                                          Text('15+',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 20)),
                                          Text('  ·  ',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 20)),
                                          Text(snapshot.data.release_date,
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 20)),
                                          Text('  ·  ',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 20)),
                                          Icon(Icons.star,
                                              color: Colors.yellow[800],
                                              size: 20.0,
                                              semanticLabel: 'Icône Etoile'),
                                          Text(snapshot.data.vote_average.toString(),
                                              style: TextStyle(
                                                  color: Colors.yellow[800], fontSize: 20)),
                                        ]),
                                        SizedBox(height: 5),

                                        Row(children: <Widget>[
                                          FlatButton(
                                            color: Colors.white,
                                            textColor: Colors.black,
                                            disabledColor: Colors.grey,
                                            disabledTextColor: Colors.black,
                                            padding: EdgeInsets.all(8.0),
                                            splashColor: Colors.transparent,
                                            onPressed: () {
                                              /*...*/
                                            },
                                            child: Text(
                                              "Crime",
                                              style: TextStyle(fontSize: 18.0),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          FlatButton(
                                            color: Colors.white,
                                            textColor: Colors.black,
                                            disabledColor: Colors.grey,
                                            disabledTextColor: Colors.black,
                                            padding: EdgeInsets.all(8.0),
                                            splashColor: Colors.transparent,
                                            onPressed: () {
                                              /*...*/
                                            },
                                            child: Text(
                                              "Drama",
                                              style: TextStyle(fontSize: 18.0),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          FlatButton(
                                            color: Colors.white,
                                            textColor: Colors.black,
                                            disabledColor: Colors.grey,
                                            disabledTextColor: Colors.black,
                                            padding: EdgeInsets.all(8.0),
                                            splashColor: Colors.transparent,
                                            onPressed: () {
                                              /*...*/
                                            },
                                            child: Text(
                                              "Mystery",
                                              style: TextStyle(fontSize: 18.0),
                                            ),
                                          ),
                                        ]),
                                      ]),




                                ),
                                Container(

                                  // Container Cast + Résumé
                                  margin: EdgeInsets.only(top: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Cast: Millie Bobby Brown, Henry Cavril, Sam Caflin, Helena Bonham Carter",
                                        style: TextStyle(color: Colors.white, fontSize: 15),
                                      ),
                                      // Spacer(),
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Summary",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              snapshot.data.overview,
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ),

                  ]);
            }
            else
              {
                return Container();
              }

        }
    );

      }
    }



class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}


enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  String _email = "";
  String _password = "";
  FormType _form = FormType
      .login; // our default setting is to login, and we should switch to creating an account when the user chooses to

  _LoginPageState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }


  void _formChange() async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
    Image.network(
    "https://image.tmdb.org/t/p/original/xJ0YBDCYNR1OIMR2XL31X5SGAHh.jpg",
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      //fit: BoxFit.cover,
    ),

      Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(top: 90),
          child: Text("Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              )),
        ),
      ),
     new Scaffold(
     // appBar: _buildBar(context),
      backgroundColor: Colors.transparent,

      body: new Container(
color: Colors.black,
        margin: const EdgeInsets.only(top: 400),
        child: new Column(

          children: <Widget>[


            _buildTextFields(),
            _buildButtons(),
          ],
        ),
      ),
    )]);
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: new Text("Page de login"),
      centerTitle: true,
    );
  }

  Widget _buildTextFields() {

        return new Container(
          margin: const EdgeInsets.only(top: 10),
      child: new Column(

        children: <Widget>[

          new Container(
            margin: const EdgeInsets.only(top: 10),
            child: new TextField(
              controller: _emailFilter,
              decoration: new InputDecoration(
                fillColor: Colors.blueGrey,
                filled: true,
                  labelText: 'Email',

              ),
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(top: 10),
            child: new TextField(
              controller: _passwordFilter,

              decoration: new InputDecoration(
                  fillColor: Colors.blueGrey,
                  filled: true,
                  labelText: 'Mot de passe',
                  border: const OutlineInputBorder(),


                suffixIcon: IconButton(icon:Icon(Icons.remove_red_eye_sharp),onPressed: hide,)
              ),
              obscureText: password,

            ),
          )
        ],
      ),
    );   // burda bitiyor
  }

  Widget _buildButtons() {
    if (_form == FormType.login) {
      return new Container(
        margin: const EdgeInsets.only(top: 40),
        child: new Column(

          children: <Widget>[
        SizedBox(
        width: double.infinity,

          child:RaisedButton(
             color: Colors.amber,
              child: new Text('LOGIN'),

              onPressed: _loginPressed,

            ),

        )],
        ),
      );
    } else {
      return new Container(
        child: new Column(
          children: <Widget>[

          ],
        ),
      );
    }
  }



  void _loginPressed() {
    if(isEmail(_email))
      {

        //_emailFilter.text = "email ok";
        print("email ok");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    else
      {
        print("email nok");
        Fluttertoast.showToast(
            msg: "Email invalide",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1
        );

      }
    //print('The user wants to login with $_email and $_password');
  }
bool password= true;
  void hide() {
     setState(() {
       this.password = !this.password;
     });
  }



  bool isEmail(String em) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

}