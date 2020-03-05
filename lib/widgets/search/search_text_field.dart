import 'package:flutter/material.dart';
import 'package:xiaozheliao/screens/search/searcher.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController _controller;
  final FocusNode _focusNode;
  final ValueChanged<String> _onSubmitted;
  final SearchType _searchType;

  SearchTextField({Key key, controller, focusNode, searchType, onSubmitted})
      : _controller = controller,
        _focusNode = focusNode,
        _onSubmitted = onSubmitted,
        _searchType = searchType,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    String hintText = '请输入...';
    if (_searchType == SearchType.ADD_FRIENDS) {
      hintText = '好友ID/手机号码';
    }
    return Expanded(
      child: TextField(
        autofocus: true,
        controller: _controller,
        focusNode: _focusNode,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        cursorColor: XzlColors.ff666666,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: XzlColors.ff999999,
            fontSize: 16.0,
          ),
        ),
        onSubmitted: _onSubmitted,
      ),
    );
  }
}
