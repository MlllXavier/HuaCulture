import 'package:flutter/material.dart';
import 'package:hua_culture/widgets/cards_widget.dart';

class VerifyPage extends StatefulWidget {
  VerifyPage({Key key}) : super(key: key);

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("审核页")),
      body: Container(
        child: Scrollbar(
            child: CardsWidget(category: 0, categoryIndex: 0, isVerify: true,)
        ),
      )
    );
  }
}