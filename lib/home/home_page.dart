import 'package:flutter/material.dart';
import 'package:vision/home/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vision"),
        actions: <Widget>[
          GestureDetector(
            onTap: () async {
              await controller.getImageGalery();
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Icon(Icons.landscape),
            ),
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.only(left: 10, right: 10),
          itemCount: controller.labels.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(color: Colors.grey.shade100),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: Text(
                  controller.labels[index].toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await controller.getImageCamera();
          setState(() {});
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}
