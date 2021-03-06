import 'package:app/blocs/signup_bloc/signup_bloc.dart';
import 'package:app/res/account_type.dart';
import 'package:app/res/assets.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/signup/widgets/account_type_card.dart';
import 'package:app/ui/features/signup/widgets/signup_form.dart';
import 'package:app/ui/widgets/screen_wrappers/simple_screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const routeName = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final textStyles = TextStyles.of(context);

    return WillPopScope(
      onWillPop: () async {
        context.read<SignUpBloc>().add(ResetBloc());
        return true;
      },
      child: SimpleScreenWrapper(
        shouldGoUnderAppBar: true,
        onBackPressed: () {
          Get.back<dynamic>();
          context.read<SignUpBloc>().add(ResetBloc());
        },
        child: BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
          if (state is SignUpInitial) {
            return SizedBox(
              width: mediaQuery.size.width,
              height: mediaQuery.size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Choose the account type",
                      style: textStyles.headerText,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  AccountTypeCard(
                    text: "Owner",
                    imagePath: Assets.ownerImage,
                    accountType: AccountType.owner,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  AccountTypeCard(
                    text: "User",
                    imagePath: Assets.userImage,
                    accountType: AccountType.user,
                  ),
                ],
              ),
            );
          } else if (state is SignUpStarted || state is SignUpFailed) {
            return SingleChildScrollView(
              child: Column(
                children: const [
                  SignUpForm(),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
