import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_its_anime_list/dependency_injection.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/get_all_mangas.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_bloc.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_event.dart';
import 'package:my_its_anime_list/features/manga/presentation/pages/manga_home_page.dart';
import 'package:my_its_anime_list/features/menu/presentation/pages/MenuPage.dart';
import '../../pages/home.dart';
import '../../bloc/authentication/auth_bloc.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  void initState() {
    BlocProvider.of<AuthBloc>(context).add(CheckEmailVerificationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(50),
                child: Image(image: AssetImage('assets/email_verify.png')),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Verify your E-Mail address',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (BuildContext context, AuthState state) {
                  if (state is EmailIsVerifiedState) {
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //   builder: (context) => BlocProvider(
                    //     create: (context) => MangaBloc(sl<GetMangaList>())
                    //       ..add(const GetMangaListEvent()),
                    //     child: const MangaHomePage(),
                    //   )));
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const MenuPage()));
                  }
                },
                builder: (context, state) {
                  if (state is EmailIsSentState) {
                    return const Center(
                        child: Text(
                      'A verification email has been dispatched; kindly verify your account to proceed.',
                      textAlign: TextAlign.center,
                    ));
                  } else if (state is ErrorAuthState) {
                    return Center(
                        child: Text(state.message,
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center));
                  } else {
                    return const Center(
                        child: Text('Sending verification email...',
                            textAlign: TextAlign.center));
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Did not receive any email?"),
                  TextButton(
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context)
                            .add(SendEmailVerificationEvent());
                      },
                      child: const Text("resend email"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
