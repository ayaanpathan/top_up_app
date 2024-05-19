import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/domain/entities/beneficiary.dart';
import 'package:top_up_app/presentation/cubits/beneficiary/beneficiary_cubit.dart';
import 'package:top_up_app/presentation/cubits/user/user_cubit.dart';
import 'package:top_up_app/presentation/widgets/alert_dialog.dart';

class AddBeneficiaryBottomSheet extends StatefulWidget {
  const AddBeneficiaryBottomSheet({super.key});

  @override
  State<AddBeneficiaryBottomSheet> createState() =>
      _AddBeneficiaryBottomSheetState();
}

class _AddBeneficiaryBottomSheetState extends State<AddBeneficiaryBottomSheet> {
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<BeneficiaryCubit, BeneficiaryState>(
      listener: (context, state) {
        if (state is BeneficiaryError) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialogWidget(
                title: 'Error!',
                content: state.message ?? 'An error occurred',
              );
            },
          );
        } else if (state is BeneficiaryLoaded) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
        builder: (context, state) {
          bool isLoading = state is BeneficiaryLoading;

          return Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black87,
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Add Beneficiary',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: nicknameController,
                    decoration: InputDecoration(
                      labelText: 'Nickname',
                      labelStyle: const TextStyle(color: Colors.white70),
                      prefixIcon: const Icon(Icons.person_outline,
                          color: Colors.white70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white70),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    maxLength: 20,
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a nickname';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: const TextStyle(color: Colors.white70),
                      prefixIcon: const Icon(Icons.phone_outlined,
                          color: Colors.white70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white70),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    maxLength: 10,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      final RegExp uaePhoneNumberRegExp =
                          RegExp(r'^(050|052|054|055|056|058)\d{7}$');
                      if (!uaePhoneNumberRegExp.hasMatch(value)) {
                        return 'Please enter a valid UAE phone number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: isLoading ? null : _saveBeneficiary,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                      elevation: 5,
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text(
                            'Save Beneficiary',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _saveBeneficiary() {
    if (_formKey.currentState!.validate()) {
      final newBeneficiary = Beneficiary(
        id: DateTime.now().toString(),
        nickname: nicknameController.text,
        phoneNumber: '+971${phoneNumberController.text.substring(1)}',
        remainingBalance:
            context.read<UserCubit>().user.isVerified ? 1000 : 500,
      );

      context.read<BeneficiaryCubit>().addNewBeneficiary(newBeneficiary);
    }
  }
}
