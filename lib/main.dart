import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/data/services/mock_http_service.dart';
import 'package:top_up_app/domain/usecases/add_beneficiary.dart';
import 'package:top_up_app/domain/usecases/get_beneficiaries.dart';
import 'package:top_up_app/domain/usecases/remove_beneficiary.dart';
import 'package:top_up_app/presentation/cubits/top_up/topup_cubit.dart';
import 'package:top_up_app/presentation/cubits/user/user_cubit.dart';
import 'package:top_up_app/presentation/pages/login_screen.dart';
import 'package:top_up_app/presentation/theme/theme_provider.dart';

import 'data/repositories/beneficiary_repository_impl.dart';
import 'presentation/cubits/beneficiary/beneficiary_cubit.dart';

void main() {
  final beneficiaryRepository = BeneficiaryRepositoryImpl();

  runApp(MyApp(
    getBeneficiaries: GetBeneficiaries(beneficiaryRepository),
    addBeneficiary: AddBeneficiary(beneficiaryRepository),
    removeBeneficiary: RemoveBeneficiary(beneficiaryRepository),
  ));
}

class MyApp extends StatelessWidget {
  final GetBeneficiaries getBeneficiaries;
  final AddBeneficiary addBeneficiary;
  final RemoveBeneficiary removeBeneficiary;

  final mockHttpService = MockHttpService();

  MyApp({
    super.key,
    required this.getBeneficiaries,
    required this.addBeneficiary,
    required this.removeBeneficiary,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => BeneficiaryCubit(
                  getBeneficiaries: getBeneficiaries,
                  addBeneficiary: addBeneficiary,
                  removeBeneficiary: removeBeneficiary,
                  httpService: mockHttpService,
                )),
        BlocProvider(
          create: (_) => TopupCubit(httpService: mockHttpService),
        ),
        BlocProvider(
          create: (_) => UserCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Top Up App',
        theme: ThemeProvider.darkTheme,
        home: const LoginScreen(),
      ),
    );
  }
}
