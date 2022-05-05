import 'package:app/blocs/signup_bloc/signup_bloc.dart';
import 'package:app/res/account_type.dart';
import 'package:app/res/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountTypeCard extends StatelessWidget {
  const AccountTypeCard({
    required this.text,
    required this.imagePath,
    required this.accountType,
    Key? key,
  }) : super(key: key);
  final String text;
  final String imagePath;
  final AccountType accountType;

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles.of(context);

    return Container(
      decoration: const BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 20.0)]),
      child: Card(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.fill,
              height: 200.0,
              width: 200.0,
            ),
            Positioned(
              bottom: 10.0,
              child: Text(
                text,
                style: textStyles.accentText,
              ),
            ),
            Positioned.fill(
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.blueAccent.withOpacity(0.4),
                    onTap: () {
                      context.read<SignUpBloc>().add(ChooseAccountType(type: accountType));
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}
