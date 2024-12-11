
import 'package:flutter/material.dart';
import 'package:myapp/nav_bar.dart';
import 'package:myapp/presentation/page/signup_page.dart';
import 'package:myapp/service/api_service.dart';

class SignInPage extends StatefulWidget {
 const  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final apiService = ApiService();
  bool _isLoading = false;

  void login(String email, String pw) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await apiService.login(email, pw);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const NavBar(),
          ));
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 32),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Email'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Password'),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : FilledButton(
                              onPressed: () async {
                                var email = emailController.text;
                                var password = passwordController.text;
                                login(email, password);
                              },
                              child: const Text('Login'),
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupPage(),
                        ));
                  },
                  child: const Text('Belum Punya Akun ?')),
            ],
          ),
        ),
      ),
    );
  }
}
