import 'package:flutter/material.dart';
import 'package:hike_it/controllers/users_controller.dart';

// import 'package:hike_it/dashboard.dart';
import 'package:hike_it/sign/sign_up.dart';
import 'package:hike_it/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_shadow/simple_shadow.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/sign/Sign_in_bg.jpg",
                    fit: BoxFit.fitWidth,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: getHeight(40),
                      ),
                      SimpleShadow(
                        child: SvgPicture.asset(
                          "assets/images/Horizontal_logo.svg",
                        ),
                      ),
                      SizedBox(
                        height: getHeight(130),
                      ),
                      Text(
                        "Selamat datang kembali.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: bold,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(1, 1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getHeight(40),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          "Mulai perjalan barumu dengan berbagai destinasi yang memesona. Jelajahi dunia di sini, jawaban para pendaki untuk menemukan perjalanan mereka.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(1, 1),
                                blurRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: getHeight(380),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: hitam.withOpacity(0.5),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: getHeight(5),
                                ),
                                const Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: bold,
                                  ),
                                ),
                                const Spacer(),
                                TextField(
                                  controller: UsersController.to.emailLogin,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: putih.withOpacity(0.9),
                                  ),
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    filled: true,
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: SvgPicture.asset(
                                        "assets/icons/sign/Message.svg",
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                    ),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    fillColor: Colors.white.withOpacity(0.25),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    hintText: 'Email Address',
                                    hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                TextField(
                                  controller: UsersController.to.passwordLogin,
                                  maxLines: 1,
                                  obscureText: !_passwordVisible,
                                  style: TextStyle(
                                    color: putih.withOpacity(0.9),
                                  ),
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    filled: true,
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        child: _passwordVisible
                                            ? SvgPicture.asset(
                                                "assets/icons/sign/Hide.svg",
                                                color: Colors.white
                                                    .withOpacity(0.9),
                                              )
                                            : const Icon(Icons.visibility,
                                                color: Colors.white),
                                      ),
                                    ),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    fillColor: Colors.white.withOpacity(0.25),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    UsersController.to.login();
                                    // Navigator.pushReplacement(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => const Dashboard(),
                                    //   ),
                                    // );
                                  },
                                  child: Container(
                                    height: getHeight(54),
                                    decoration: BoxDecoration(
                                      gradient: gradient,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "SIGN IN",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                // InkWell(
                                //   onTap: () {},
                                //   child: const Center(
                                //     child: Text(
                                //       "forgot password",
                                //       style: TextStyle(
                                //           color: Colors.white,
                                //           decoration: TextDecoration.underline),
                                //     ),
                                //   ),
                                // ),
                                // const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Don't have an account? ",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUp(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          color: ungu,
                                          fontWeight: bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
