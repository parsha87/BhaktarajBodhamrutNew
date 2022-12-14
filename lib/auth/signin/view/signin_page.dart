import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/colors.dart';
import '../../../widgets/appbar.dart';
import '../../bloc/auth_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(
        appBar: AppBar(),
        title: 'Sign In',
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (route) => false,
            );
          }
          if (state is AuthError) {
            // Showing the error message if the user has entered invalid credentials
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              // Showing the loading indicator while the user is signing in
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UnAuthenticated) {
              // Showing the sign in form if the user is not authenticated
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Bodhamrut',
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              ?.copyWith(fontSize: 32),
                        ),
                        const SizedBox(height: 40),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  hintText: 'Email',
                                  border: OutlineInputBorder(),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null &&
                                          !EmailValidator.validate(value)
                                      ? 'Enter a valid email'
                                      : null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  hintText: 'Password',
                                  border: OutlineInputBorder(),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null && value.length < 6
                                      ? 'Enter min. 6 characters'
                                      : null;
                                },
                              ),
                              const SizedBox(height: 40),
                              GestureDetector(
                                onTap: () {
                                  _authenticateWithEmailAndPassword(
                                    context,
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    decoration: const BoxDecoration(
                                      color: AppColors.buttonColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Sign In',
                                        style:
                                            Theme.of(context).textTheme.button,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                _authenticateWithGoogle(context);
                              },
                              icon: Image.network(
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1200px-Google_%22G%22_Logo.svg.png',
                                height: 30,
                                width: 30,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Don't have an account?"),
                            const SizedBox(
                              height: 10,
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: AppColors.buttonColor,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/signup',
                                );
                              },
                              child: Text(
                                'Sign Up',
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(
                                      color: AppColors.orangeTextColor,
                                    ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _authenticateWithEmailAndPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(_emailController.text, _passwordController.text),
      );
    }
  }

  void _authenticateWithGoogle(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }
}
