import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/Role_based_login/User/Screen/user_app_main_screen.dart';
import 'package:flutter_application_1/Views/Role_based_login/User/login_screen.dart';
import 'package:flutter_application_1/services/auth_serivices.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController eCont = TextEditingController();
  TextEditingController pCont = TextEditingController();
  TextEditingController nmCont = TextEditingController();
bool _isObscured = true; // Password hidden by default

  final AuthService authService = AuthService();

  void signUp() async {
    
    // Basic local validation first
    if (nmCont.text.isEmpty || eCont.text.isEmpty || pCont.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all the fields")),
      );
      return;
    }

    String? result = await authService.signUp(
      name: nmCont.text,
      email: eCont.text,
      password: pCont.text,
    );
    

    if (result == null) {
      // SUCCESS: result is null, user successfully created
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sign Up Successful!")),
      );
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const UserAppMainScreen(),
        ),
      );
    } else {
      // ERROR: result contains the error message string
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Clean white background like the image
      body: SafeArea(
        child: SingleChildScrollView(
          // Added scroll to prevent overflow on small screens
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to left
              children: [
                const SizedBox(height: 20),

                // Header Text instead of just Image (Cleaner look)
                const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Sign up to continue",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 40),

                // Name input - Enhanced Style
                TextField(
                  controller: nmCont,
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Email input - Enhanced Style
                TextField(
                  controller: eCont,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "E-mail Address",
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Password input - Enhanced Style
                // Password input
TextField(
  controller: pCont,
  obscureText: _isObscured, // Uses the state variable
  decoration: InputDecoration(
    labelText: "Password",
    labelStyle: const TextStyle(color: Colors.grey),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.black,
        width: 2,
      ),
    ),
    // Wrapped the icon in an IconButton to make it clickable
    suffixIcon: IconButton(
      icon: Icon(
        _isObscured ? Icons.visibility_off : Icons.visibility,
        color: Colors.grey,
      ),
      onPressed: () {
        setState(() {
          _isObscured = !_isObscured; // Toggles between true and false
        });
      },
    ),
  ),
),

                const SizedBox(height: 30),

                // Sign Up Button - Black style like "SHOP NOW" in image
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: signUp,
                        
                    
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.black, // Matches the dark theme in image
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Login Link Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already Have an Account? ",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Login here",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Dark color for contrast
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
