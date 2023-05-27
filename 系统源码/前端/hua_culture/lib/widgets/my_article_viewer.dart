import 'package:flutter/material.dart';
import 'package:hua_culture/entity/article_entity.dart';

class ArticleViewerWithLimit extends StatefulWidget {
  final ArticleEntity article;

  ArticleViewerWithLimit({Key key, @required this.article}) : super(key: key);

  @override
  _ArticleViewerWithLimitState createState() => _ArticleViewerWithLimitState();
}

class _ArticleViewerWithLimitState extends State<ArticleViewerWithLimit> {
  ArticleEntity _articleEntity = new ArticleEntity();
  bool _isLimit = true;

  void _switchToWithoutLimit(){
    setState(() {
      _isLimit = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _articleEntity = widget.article;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: !_isLimit
        ? ArticleViewerWithoutLimit(article: _articleEntity,)
        : GestureDetector(//否则监测手势
      onTap: Feedback.wrapForTap((_switchToWithoutLimit), context),
      child: Text(
        _articleEntity.content,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 24.0,
          height: 1.2,
        ),
      ),
      )
    );
  }
}

class ArticleViewerWithoutLimit extends StatefulWidget {
  final ArticleEntity article;
  ArticleViewerWithoutLimit({Key key, @required this.article}) : super(key: key);

  @override
  _ArticleViewerWithoutLimitState createState() => _ArticleViewerWithoutLimitState();
}

class _ArticleViewerWithoutLimitState extends State<ArticleViewerWithoutLimit> {
  ArticleEntity _articleEntity = new ArticleEntity();
  bool _isLimit = false;

  void _switchToWithLimit(){
    setState(() {
      _isLimit = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _articleEntity = widget.article;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _isLimit
        ? ArticleViewerWithLimit(article: _articleEntity,)
        : GestureDetector(//否则监测手势
      onTap: Feedback.wrapForTap((_switchToWithLimit), context),
      child: Text(
          _articleEntity.content,
          style: TextStyle(
            fontSize: 24.0,
            height: 1.2,
          ),
        ),
      )
    );
  }
}