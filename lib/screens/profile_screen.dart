import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quadball_manager/services/services.dart';
import 'package:quadball_manager/models/models.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<UserLocCubit, UserLocState>(
      builder: (_, state) {
        if (state is UserLocReadyState) {
          return _UserLocSection(
            user: state.user,
            pikedImage: state.pickedImage,
            isSaving: state.isSaving,
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    ));
  }
}

class _UserLocSection extends StatefulWidget {
  final UserLoc? user;
  final File? pikedImage;
  final bool isSaving;

  const _UserLocSection({this.user, this.pikedImage, this.isSaving = false});

  @override
  State<StatefulWidget> createState() => _UserLocSectionState();
}

class _UserLocSectionState extends State<_UserLocSection> {
  final _formKey = GlobalKey<FormBuilderState>();
  final piker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset(
      'assets/images/quidditchAppLogo.jpeg',
      fit: BoxFit.fill,
    );
    if (widget.pikedImage != null) {
      image = Image.file(
        widget.pikedImage!,
        fit: BoxFit.fill,
      );
    } else if (widget.user?.image != null && widget.user!.image!.isNotEmpty) {
      image = CachedNetworkImage(
        imageUrl: widget.user!.image!,
        progressIndicatorBuilder: (_, __, progress) =>
            CircularProgressIndicator(
          value: progress.progress,
        ),
        errorWidget: (_, __, ___) => const Icon(Icons.error),
        fit: BoxFit.fill,
      );
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                final pikedImage =
                    await piker.pickImage(source: ImageSource.gallery);
                if (pikedImage != null) {
                  context.read<UserLocCubit>().setImage(File(pikedImage.path));
                }
              },
              child: Center(
                child: ClipOval(
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: image,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (_, current) => current is AuthSignedIn,
                builder: (_, state) {
                  return Center(
                    child: Text("ID User: ${(state as AuthSignedIn).user.uid}"),
                  );
                }),
            Column(
              children: <Widget>[
                FormBuilder(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          name: "name",
                          initialValue: widget.user?.name,
                          decoration: const InputDecoration(labelText: "Name"),
                          validator: FormBuilderValidators.required(
                              errorText: "This File is Required"),
                        ),
                        FormBuilderTextField(
                          name: "lastName",
                          initialValue: widget.user?.lastName,
                          decoration:
                              const InputDecoration(labelText: "Last Name"),
                          validator: FormBuilderValidators.required(
                              errorText: "This File is Required"),
                        ),
                        FormBuilderTextField(
                          name: "age",
                          initialValue: widget.user?.age.toString(),
                          decoration: const InputDecoration(labelText: "Age"),
                          keyboardType: TextInputType.number,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: "This File is Required"),
                            FormBuilderValidators.numeric(
                                errorText: 'Age must be numeric.'),
                            FormBuilderValidators.min(16),
                          ]),
                        ),
                        FormBuilderDropdown(
                          name: 'gender',
                          initialValue: widget.user?.gender,
                          decoration: const InputDecoration(
                            labelText: 'Gender',
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: '',
                              child: Text('Select Gender'),
                            ),
                            DropdownMenuItem(
                              value: 'Male',
                              child: Text('Male'),
                            ),
                            DropdownMenuItem(
                              value: 'Female',
                              child: Text('Female'),
                            ),
                            DropdownMenuItem(
                              value: 'Non Binary',
                              child: Text('Non Binary'),
                            ),
                            DropdownMenuItem(
                              value: 'Fluid',
                              child: Text('Fluid'),
                            ),
                          ],
                          validator: FormBuilderValidators.required(
                              errorText: "This File is Required"),
                        ),
                        FormBuilderDropdown(
                          name: 'rol',
                          initialValue: widget.user?.rol,
                          decoration: const InputDecoration(
                            labelText: 'Rol',
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: '',
                              child: Text('Select Rol'),
                            ),
                            DropdownMenuItem(
                              value: "Team",
                              child: Text('Team'),
                            ),
                            DropdownMenuItem(
                              value: "Player",
                              child: Text('Player'),
                            )
                          ],
                          validator: FormBuilderValidators.required(
                              errorText: "This File is Required"),
                        ),
                        FormBuilderCheckboxGroup<dynamic>(
                          name: 'positions',
                          initialValue: widget.user?.positions,
                          decoration: const InputDecoration(
                            labelText: 'Positions Player',
                          ),
                          options: const [
                            FormBuilderFieldOption(value: "Keeper"),
                            FormBuilderFieldOption(value: "Chasers"),
                            FormBuilderFieldOption(value: "Beaters"),
                            FormBuilderFieldOption(value: "Seekers"),
                          ],
                        ),
                        FormBuilderCheckboxGroup<dynamic>(
                          name: 'arbitrage',
                          initialValue: widget.user?.arbitrageTitles,
                          decoration: const InputDecoration(
                            labelText: 'Arbitration Titles',
                          ),
                          options: const [
                            FormBuilderFieldOption(value: "Head Referee"),
                            FormBuilderFieldOption(value: "Assistant Referee"),
                            FormBuilderFieldOption(value: "Table Refree"),
                            FormBuilderFieldOption(value: "Gol Referee"),
                            FormBuilderFieldOption(value: "Snitch Refree"),
                          ],
                        ),
                      ],
                    )),
                Row(
                  children: <Widget>[
                    MaterialButton(
                      onPressed: widget.isSaving
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<UserLocCubit>().saveUserLoc(
                                    (context.read<AuthCubit>().state
                                            as AuthSignedIn)
                                        .user
                                        .uid,
                                    _formKey
                                        .currentState!.fields['name']!.value,
                                    _formKey.currentState!.fields['lastName']!
                                        .value,
                                    int.parse(_formKey
                                        .currentState!.fields['age']!.value),
                                    _formKey
                                        .currentState!.fields['gender']!.value,
                                    _formKey.currentState!.fields['rol']!.value,
                                    _formKey.currentState!.fields['positions']!
                                        .value,
                                    _formKey.currentState!.fields['arbitrage']!
                                        .value);
                              }
                            },
                      child: const Text("Save"),
                    ),
                    MaterialButton(
                      child: const Text("Reset"),
                      onPressed: () {
                        _formKey.currentState!.reset();
                      },
                    ),
                    if (widget.isSaving) const CircularProgressIndicator(),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
