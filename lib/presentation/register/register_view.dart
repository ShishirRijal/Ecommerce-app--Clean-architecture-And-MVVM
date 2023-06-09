import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:ecommerce_app/app/di.dart';
import 'package:ecommerce_app/presentation/register/register_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../core.dart/core.dart';
import '../common/state_renderer/state_render_implementer.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = getIt<RegisterViewModel>();

  final _formKey = GlobalKey<FormState>();
  ImagePicker picker = getIt<ImagePicker>();
  final TextEditingController _userNameTextEditingController =
      TextEditingController();
  final TextEditingController _mobileNumberTextEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  _bind() {
    _viewModel.start();
    _userNameTextEditingController.addListener(() {
      _viewModel.setUserName(_userNameTextEditingController.text);
    });

    _passwordEditingController.addListener(() {
      _viewModel.setPassword(_passwordEditingController.text);
    });

    _emailEditingController.addListener(() {
      _viewModel.setEmail(_emailEditingController.text);
    });

    _mobileNumberTextEditingController.addListener(() {
      _viewModel.setMobileNumber(_mobileNumberTextEditingController.text);
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
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        iconTheme: const IconThemeData(color: ColorManager.primary),
        backgroundColor: ColorManager.white,
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return Center(
            child: snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _viewModel.register();
                }) ??
                _getContentWidget(),
          );
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
        padding: const EdgeInsets.only(top: AppPadding.p30),
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
                  child: StreamBuilder<String?>(
                    stream: _viewModel.usernameErrorText,
                    builder: (context, snapshot) {
                      return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _userNameTextEditingController,
                          decoration: InputDecoration(
                              hintText: AppString.username,
                              labelText: AppString.username,
                              errorText: snapshot.data));
                    },
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: AppPadding.p20,
                        left: AppPadding.p28,
                        right: AppPadding.p28,
                        bottom: AppPadding.p12),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: CountryCodePicker(
                              onChanged: (country) {
                                // update view model with the selected code
                                _viewModel
                                    .setCountryCode(country.dialCode ?? "");
                              },
                              initialSelection: "+33",
                              showCountryOnly: true,
                              hideMainText: true,
                              showOnlyCountryWhenClosed: true,
                              favorite: const ["+977", "+966", "+39"],
                            )),
                        Expanded(
                            flex: 3,
                            child: StreamBuilder<String?>(
                              stream: _viewModel.mobileNumberErrorText,
                              builder: (context, snapshot) {
                                return TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller:
                                        _mobileNumberTextEditingController,
                                    decoration: InputDecoration(
                                        hintText: AppString.mobileNumber,
                                        labelText: AppString.mobileNumber,
                                        errorText: snapshot.data));
                              },
                            ))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s12),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<String?>(
                    stream: _viewModel.emailErrorText,
                    builder: (context, snapshot) {
                      return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailEditingController,
                          decoration: InputDecoration(
                              hintText: AppString.emailHint,
                              labelText: AppString.emailHint,
                              errorText: snapshot.data));
                    },
                  ),
                ),
                const SizedBox(height: AppSize.s12),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppPadding.p12,
                      left: AppPadding.p28,
                      right: AppPadding.p28),
                  child: StreamBuilder<String?>(
                    stream: _viewModel.passwordErrorText,
                    builder: (context, snapshot) {
                      return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordEditingController,
                          decoration: InputDecoration(
                              hintText: AppString.password,
                              labelText: AppString.password,
                              errorText: snapshot.data));
                    },
                  ),
                ),
                const SizedBox(height: AppSize.s12),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppPadding.p12,
                      left: AppPadding.p28,
                      right: AppPadding.p28),
                  child: Container(
                    height: AppSize.s40,
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorManager.lightGrey)),
                    child: GestureDetector(
                      child: _getMediaWidget(),
                      onTap: () {
                        _showPicker(context);
                      },
                    ),
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
                                    _viewModel.register();
                                  }
                                : null,
                            child: const Text(AppString.registerNow),
                          ),
                        );
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppPadding.p8,
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(AppString.haveAccount,
                        style: Theme.of(context).textTheme.labelMedium),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p8, right: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(child: Text(AppString.profilePicture)),
          Flexible(
              child: StreamBuilder<File?>(
            stream: _viewModel.outputProfilePicture,
            builder: (context, snapshot) {
              return _imagePickedByUser(snapshot.data);
            },
          )),
          Flexible(child: SvgPicture.asset(SvgAssets.camera)),
        ],
      ),
    );
  }

  Widget _imagePickedByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    } else {
      return Container();
    }
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  trailing: const Icon(Icons.arrow_forward),
                  leading: const Icon(Icons.camera),
                  title: const Text(
                    AppString.photoGallery,
                  ),
                  onTap: () {
                    _imageFormGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  trailing: const Icon(Icons.arrow_forward),
                  leading: const Icon(Icons.camera_alt_rounded),
                  title: const Text(AppString.photoCamera),
                  onTap: () {
                    _imageFormCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  _imageFormGallery() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  _imageFormCamera() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
