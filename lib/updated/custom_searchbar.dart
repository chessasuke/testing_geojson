import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef void StringCallback(String val);

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({this.callback});

  final StringCallback callback;

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 50,
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 250),
                decoration: BoxDecoration(
                  color: Colors.transparent.withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Theme.of(context).accentColor),
                ),
                child: TextField(
                  textAlign: TextAlign.center,
                  onChanged: widget.callback,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(top: 5),
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    hintText: "Search Building",
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
