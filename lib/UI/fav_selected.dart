
import 'package:flutter/material.dart';

class FavoriteWordsRoute extends StatelessWidget {
  final List<String>? favoriteItems;

  const FavoriteWordsRoute({ @required this.favoriteItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites words'),
      ),
      body: ListView.separated(
        itemCount: favoriteItems!.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) => ListTile(
          title: Text(favoriteItems![index]),
        ),
      ),
    );
  }
}