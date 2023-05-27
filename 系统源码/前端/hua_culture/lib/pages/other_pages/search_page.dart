import 'package:flutter/material.dart';
import 'package:hua_culture/widgets/cards_widget.dart';

class SearchBarDelegete extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () => query = ""),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        child: CardsWidget(category: 0, categoryIndex: 0, query: query,)
      )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentSuggest
        : searchList.where((element) => element.startsWith(query)).toList();

    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) => ListTile(
          title: RichText(
              text: TextSpan(
                  text: suggestionList[index].substring(0, query.length),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  children: [
            TextSpan(
                text: suggestionList[index].substring(query.length),
                style: TextStyle(color: Colors.grey))
          ]))));
  }
}

const searchList = [
  "1中华历史", 
  "2起源", 
  "3成就", 
  "英雄", 
  "语言与文学", 
  "语言", 
  "文字", 
  "诗词", 
  "对联", 
  "灯谜", 
  "小说", 
  "著作", 
  "寓言"
];

const recentSuggest = [
  "中华历史", 
  "起源", 
  "成就", 
  "英雄", 
  "语言与文学", 
  "语言", 
  "文字", 
  "诗词", 
  "对联", 
  "灯谜", 
  "小说", 
  "著作", 
  "寓言"
];