import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xiaozheliao/app/ticker.dart';
import 'package:xiaozheliao/blocs/sms/sms_bloc.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import 'package:xiaozheliao/widgets/account/form_text_field.dart';
import 'package:xiaozheliao/widgets/account/send_sms_text_field.dart';
import 'package:xiaozheliao/widgets/account/submit_button.dart';
import 'package:xiaozheliao/widgets/lt_back_button.dart';

class EditPasswordScreen extends StatefulWidget {
  final UserRepository _userRepository;

  EditPasswordScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EditPasswordScreenState();
  }
}

class EditPasswordScreenState extends State<EditPasswordScreen> {
  TextEditingController _mobileController,
      _passwordController,
      _verifyPasswordController,
      _smsController;

  @override
  void initState() {
    super.initState();
    _mobileController = TextEditingController();
    _passwordController = TextEditingController();
    _verifyPasswordController = TextEditingController();
    _smsController = TextEditingController();
  }

  @override
  void dispose() {
    _mobileController?.dispose();
    _passwordController?.dispose();
    _verifyPasswordController?.dispose();
    _smsController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Image.asset('assets/images/account/bg.png'),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FormTextField(
                                image: 'assets/images/account/icons/mobile.png',
                                hintText: '请输入手机号',
                                controller: _mobileController,
                                vertical: 5.0,
                                keyboardType: TextInputType.phone,
                                obscureText: true,
                              ),
                              FormTextField(
                                image: 'assets/images/account/icons/lock.png',
                                hintText: '设置登录密码，为6-20位字母和数字组成',
                                controller: _passwordController,
                                vertical: 5.0,
                                keyboardType: TextInputType.text,
                              ),
                              FormTextField(
                                image: 'assets/images/account/icons/lock.png',
                                hintText: '再次输入密码',
                                controller: _verifyPasswordController,
                                vertical: 5.0,
                                keyboardType: TextInputType.text,
                              ),
                              BlocProvider(
                                create: (context) => SmsBloc(
                                  ticker: Ticker(),
                                  userRepository: widget._userRepository,
                                ),
                                child: SendSmsTextField(
                                  vertical: 5.0,
                                  controller: _smsController,
                                  mobileController: _mobileController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          margin: EdgeInsets.only(top: 37.0, bottom: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SubmitButton(
                                text: '完成',
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Row(
              children: <Widget>[
                SizedBox(width: 4.0),
                LTBackButton(color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
