import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          //IMAGE
          Image.asset(
            'assets/images/home.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Signuppage(),
                    )),
                child: Center(
                  child: Container(
                    height: screenHeight * 0.07,
                    width: screenWidth * 0.85,
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: const Center(
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.04),
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      )),
                  child: Center(
                    child: Container(
                      height: screenHeight * 0.07,
                      width: screenWidth * 0.85,
                      decoration: BoxDecoration(
                          color: Colors.green.shade900,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30))),
                      child: const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
