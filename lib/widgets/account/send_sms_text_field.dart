import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xiaozheliao/app/validators.dart';
import 'package:xiaozheliao/blocs/sms/sms_bloc.dart';
import 'package:xiaozheliao/blocs/sms/sms_event.dart';
import 'package:xiaozheliao/blocs/sms/sms_state.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';

import 'form_text_field.dart';

class SendSmsTextField extends StatelessWidget {
  final TextEditingController _controller;
  final TextEditingController _mobileController;
  final double _vertical;

  SendSmsTextField({
    Key key,
    TextEditingController controller,
    TextEditingController mobileController,
    double vertical,
  })  : assert(controller != null),
        assert(mobileController != null),
        _controller = controller,
        _vertical = vertical ?? 8.0,
        _mobileController = mobileController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: FormTextField(
            image: 'assets/images/account/icons/sms.png',
            hintText: '请输入验证码',
            vertical: _vertical,
            controller: _controller,
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        BlocBuilder<SmsBloc, SmsState>(
          condition: (previousState, state) =>
              state.runtimeType != previousState.runtimeType,
          builder: (context, state) => _mapStateToSmsButtons(
            smsBloc: BlocProvider.of<SmsBloc>(context),
          ),
        ),
      ],
    );
  }

  Widget _mapStateToSmsButtons({SmsBloc smsBloc}) {
    final SmsState currentState = smsBloc.state;
    if (currentState is Finished) {
      smsBloc.add(Reset());
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: 100.0,
        height: 30.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: XzlColors.fffbbc63,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: BlocBuilder<SmsBloc, SmsState>(
          builder: (context, state) {
            String btnTxt = '获取验证码';
            if (state is Running) {
              String secondsStr =
                  (state.duration % 60).floor().toString().padLeft(2, '0');
              if (state.duration == 60) secondsStr = '60';
              btnTxt = '请稍候 ${secondsStr}s';
            }
            return Text(
              '$btnTxt',
              style: TextStyle(color: Colors.white),
            );
          },
        ),
      ),
      onTap: () => _sendSmsCaptcha(smsBloc: smsBloc),
    );
  }

  void _sendSmsCaptcha({SmsBloc smsBloc}) {
    final SmsState currentState = smsBloc.state;
    if (currentState is Running) return;
    String mobile = _mobileController.text.trim();
    if (Validators.isValidMobile(mobile)) {
      smsBloc.add(Start(
        duration: currentState.duration,
        mobile: mobile,
      ));
      Fluttertoast.showToast(
        msg: '发送验证码成功',
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
      );
    } else {
      Fluttertoast.showToast(
        msg: '请输入有效的手机号码',
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
      );
    }
  }
}
