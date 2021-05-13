import 'package:flutter/material.dart';
import 'package:flutter_method_channel/bridge_service.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String platformValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(platformValue),
              const SizedBox(
                height: 44,
              ),
              ElevatedButton(
                child: Text('Get Method1 Channel Value'),
                onPressed: _getMethod1Value,
              ),
              const SizedBox(
                height: 44,
              ),
              ElevatedButton(
                child: Text('Get Method2 Channel Value'),
                onPressed: _getMethod2Value,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getMethod1Value() {
    BridgetService.getNoArgsWithReturnValue().then((value) {
      setState(() {
        platformValue = value;
      });
    });
  }

  void _getMethod2Value() {
    BridgetService.getWithArgsWithReturnValue('★★').then((value) {
      setState(() {
        platformValue = value;
      });
    });
  }
}
