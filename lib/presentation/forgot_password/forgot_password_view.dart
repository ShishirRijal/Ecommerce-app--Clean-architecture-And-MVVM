import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/app/di.dart';
import 'package:flutter/material.dart';

import '../../core.dart/core.dart';
import '../common/state_renderer/state_render_implementer.dart';
import 'forgot_password_viewmodel.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final ForgotPasswordViewModel _viewModel = getIt<ForgotPasswordViewModel>();
  final _formKey = GlobalKey<FormState>();
  final _emailTextEditingController = TextEditingController();

  _bind() {
    _viewModel.start();
    _emailTextEditingController.addListener(() {
      _viewModel.setEmail(_emailTextEditingController.text);
    });
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.forgotPassword();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
      constraints: const BoxConstraints.expand(),
      padding: const EdgeInsets.only(top: AppPadding.p100),
      color: ColorManager.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Image(image: AssetImage(ImageAssets.splashLogo)),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder(
                    stream: _viewModel.isEmailValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailTextEditingController,
                        decoration: InputDecoration(
                          hintText: AppString.emailHint.tr(),
                          labelText: AppString.emailHint.tr(),
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppString.invalidEmail.tr(),
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: SizedBox(
                  width: double.infinity,
                  height: AppSize.s40,
                  child: StreamBuilder(
                      stream: _viewModel.isEmailValid,
                      builder: (context, snapshot) {
                        return ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  _viewModel.forgotPassword();
                                }
                              : null,
                          child: Text(AppString.resetPassword.tr()),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
