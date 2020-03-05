import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xiaozheliao/blocs/searcher/searcher_bloc.dart';
import 'package:xiaozheliao/models/user.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import 'package:xiaozheliao/screens/search/searcher.dart';

class SearcherScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final SearchType _searchType;
  final User _user;

  SearcherScreen({
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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearcherBloc(userRepository: _userRepository),
      child: Searcher(
        userRepository: _userRepository,
        searchType: _searchType,
        user: _user,
      ),
    );
  }
}
