import 'package:crowdsource_fact_checker/userConstants.dart';
import 'package:flutter/material.dart';



class AboutPage extends StatefulWidget {
  const AboutPage({Key? key,}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("About Page"),
      ),
      body: ListView(
        children: [
         Column(
          mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(80,40,80,20),
                child: Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(800.0),
                      child: Image.network("https://cdn.discordapp.com/attachments/888548685288448051/888961422149709824/Crowdcheck.png")),
                ),
              ),
                Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 20),
                child: Text(
                  "Who We Are",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage:
                        NetworkImage("https://media-exp1.licdn.com/dms/image/C4E03AQHVIlQzI7r7lA/profile-displayphoto-shrink_800_800/0/1629850333470?e=1637798400&v=beta&t=BNn6ZjGSFw5JHVlWmzr3ARBtUvhtyQn3z9amermMQjE"),
                        backgroundColor: Colors.transparent,
                      ),
                      Text(
                        "Bradley",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage:
                        NetworkImage("https://cdn.discordapp.com/attachments/888548685288448051/888974735948521542/headshot_hargunbhalla.jpg"),
                        backgroundColor: Colors.transparent,
                      ),
                      Text(
                        "Hargun",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage:
                        NetworkImage("https://media-exp1.licdn.com/dms/image/C5603AQGlpfGtB8E9iA/profile-displayphoto-shrink_800_800/0/1575766098378?e=1637798400&v=beta&t=5QAIOtr9X49wGTxzw3-v5eyrA682xZn67dAstdrg-YA"),
                        backgroundColor: Colors.transparent,
                      ),
                      Text(
                        "Mikhail",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "What We Do",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                child: Text(
                  "We here at crowdcheck have developed a crowdsourced fact-checking platform, where users receive credible and non-bias information about the issues they care most about. They also have the opportunity to submit information, submit comments to post thread, and build out their profile.",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Values",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                child: Text(
                  "Misinformation regarding science and other research based fields has been on the rise, given the upcoming Canadian Federal election and ongoing COVID-19 pandemic. We hope to solve this problem through crowdcheck, one post at a time.",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
            ],
        ),
          Container(height: 50,)
        ],
      ),
    );
  }
}
