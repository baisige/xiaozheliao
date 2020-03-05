import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xiaozheliao/blocs/searcher/bloc.dart';
import 'package:xiaozheliao/blocs/searcher/searcher_bloc.dart';
import 'package:xiaozheliao/models/user.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';
import 'package:xiaozheliao/widgets/lt_back_button.dart';
import 'package:xiaozheliao/widgets/search/clean_text_button.dart';
import 'package:xiaozheliao/widgets/search/search_add_friend_info.dart';
import 'package:xiaozheliao/widgets/search/search_text_field.dart';
import 'package:xiaozheliao/widgets/search/text_search_button.dart';

enum SearchType { SEARCH, ADD_FRIENDS }

class Searcher extends StatefulWidget {
  final UserRepository _userRepository;
  final SearchType _searchType;
  final User _user;

  Searcher({
    Key key,
    @required UserRepository userRepository,
    SearchType searchType,
    @required User user,
  })  : assert(userRepository != null),
        assert(user != null),
        _userRepository = userRepository,
        _searchType = searchType ?? SearchType.SEARCH,
        _user = user,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearcherState();
  }
}

class _SearcherState extends State<Searcher> {
  SearcherBloc _searcherBloc;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _searcherBloc = BlocProvider.of<SearcherBloc>(context);
    _controller.addListener(_keywordChanged);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 4.0),
                  LTBackButton(color: XzlColors.ff333333),
                  SearchTextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    searchType: widget._searchType,
                    onSubmitted: (value) => _searchFriends(value),
                  ),
                  BlocBuilder<SearcherBloc, SearcherState>(
                    condition: (previousState, state) =>
                        state is KeywordChanging,
                    builder: (context, state) {
                      bool isClean;
                      if (state is KeywordChanging) {
                        isClean = state.isClean;
                      }
                      return CleanTextButton(
                        color: XzlColors.ff999999,
                        size: 16.0,
                        visible: isClean,
                        onPressed: _cleanKeyword,
                      );
                    },
                  ),
                  TextSearchButton(
                    color: Colors.blueAccent,
                    onTap: () => _searchFriends(_controller.text),
                  ),
                  SizedBox(width: 8.0),
                ],
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<SearcherBloc, SearcherState>(
        condition: (previousState, state) => state is! KeywordChanging,
        builder: (context, state) {
          if (state is SearcherLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is SearcherError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(
                  color: XzlColors.ff999999,
                  fontSize: 16.0,
                ),
              ),
            );
          }
          if (state is SearcherFriendLoaded) {
            return SearchAddFriendInfo(
              userRepository: widget._userRepository,
              friend: state.friend,
              focusNode: _focusNode,
              user: widget._user,
            );
          }
          return Container();
        },
      ),
    );
  }

  void _keywordChanged() {
    _searcherBloc.add(KeywordChanged(keyword: _controller.text.trim()));
  }

  void _cleanKeyword() {
    _controller.clear();
    FocusScope.of(context).requestFocus(_focusNode);
  }

  void _searchFriends(String keyword) {
    FocusScope.of(context).requestFocus(_focusNode);
    if (keyword.isNotEmpty) {
      _searcherBloc.add(UserFetched(uid: widget._user.uid, keyword: keyword));
    }
  }
}
