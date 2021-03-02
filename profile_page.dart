import 'package:flutter/material.dart';
import 'size_config.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(height: 24, width: 24),
          CircleAvatar(
            radius: 70,
            child: ClipOval(
              child: Image.asset(
                'assets/profile_pic.jpg',
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(height: 48, width: 24),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[500],
                borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(SizeConfig.screenWidth, 50.0),
                    bottom: Radius.elliptical(SizeConfig.screenWidth, 100.0)),
              ),
              child: Column(
                children: [
                  Container(height: 48, width: 24),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                    child: Container(
                      height: 60,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Chan Yik Siong',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border:
                              Border.all(width: 1.0, color: Colors.white70)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                    child: Container(
                      height: 60,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Software Engineer',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border:
                              Border.all(width: 1.0, color: Colors.white70)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                    child: Container(
                      height: 60,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'linkedin.com/in/chanyiksiong',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border:
                              Border.all(width: 1.0, color: Colors.white70)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
