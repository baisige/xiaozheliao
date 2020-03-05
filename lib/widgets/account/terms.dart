import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xiaozheliao/blocs/register/bloc.dart';
import 'package:xiaozheliao/blocs/register/register_bloc.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';

class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _toggleTermsAgree(RegisterState state) {
      BlocProvider.of<RegisterBloc>(context).add(TermsAgreed(
        isAgree: !state.isAgree,
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            String img = state.isAgree
                ? 'assets/images/account/check/checked.png'
                : 'assets/images/account/check/uncheck.png';
            Color color =
                state.isAgree ? XzlColors.ff53cac3 : XzlColors.ffbcbcbc;
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: <Widget>[
                  ImageIcon(
                    AssetImage(img),
                    size: 14.0,
                    color: color,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    '同意 《用户协议》《隐私条款》',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: XzlColors.ffbbbbbb,
                    ),
                  ),
                ],
              ),
              onTap: () => _toggleTermsAgree(state),
            );
          },
        ),
      ],
    );
  }
}
