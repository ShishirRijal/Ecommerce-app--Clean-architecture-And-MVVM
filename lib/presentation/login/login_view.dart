import 'package:ecommerce_app/presentation/common/state_renderer/state_render_implementer.dart';
import 'package:ecommerce_app/presentation/login/login_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../app/di.dart';
import '../../core.dart/core.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = getIt<LoginViewModel>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _bind() {
    _viewModel.start(); // bind viewmodel to view
    // * Here we are listening to the stream of username and password
    _userNameController.addListener(() {
      _viewModel.setUsername(_userNameController.text);
    });
    _passwordController.addListener(() {
      _viewModel.setPassword(_passwordController.text);
    });
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data
                  ?.getScreenWidget(context, _getContentWidget(context), () {
                _viewModel.login();
              }) ??
              _getContentWidget(context);
        },
      ),
    );
  }

  Widget _getContentWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      child: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Image(image: AssetImage(ImageAssets.splashLogo)),
            const SizedBox(height: AppSize.s28),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p28, right: AppPadding.p28),
              child: StreamBuilder<bool>(
                stream: _viewModel.isUsernameValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _userNameController,
                    decoration: InputDecoration(
                        hintText: AppString.username,
                        labelText: AppString.username,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppString.usernameError),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSize.s28),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p28, right: AppPadding.p28),
              child: StreamBuilder<bool>(
                stream: _viewModel.isPasswordValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        hintText: AppString.password,
                        labelText: AppString.password,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppString.passwordError),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSize.s28),
            Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.isAllInputsValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  _viewModel.login();
                                }
                              : null,
                          child: const Text(AppString.login)),
                    );
                  },
                )),
            Padding(
              padding: const EdgeInsets.only(
                top: AppPadding.p8,
                left: AppPadding.p28,
                right: AppPadding.p28,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.forgotPasswordRoute);
                      },
                      child: Text(AppString.forgotPassword,
                          style: Theme.of(context).textTheme.labelMedium),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.registerRoute);
                      },
                      child: Text(AppString.registerNow,
                          style: Theme.of(context).textTheme.labelMedium),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
