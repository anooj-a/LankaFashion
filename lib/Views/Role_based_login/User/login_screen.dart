import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/Role_based_login/User/Screen/user_app_main_screen.dart';
import 'package:flutter_application_1/Views/Role_based_login/User/SignUp_screen.dart';
import 'package:flutter_application_1/services/auth_serivices.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController eCont = TextEditingController();
  TextEditingController pCont = TextEditingController();
bool _isObscured = true; // Password hidden by default
  final AuthService authService = AuthService();

void login() async {
    
    // Basic local validation first
    if (eCont.text.isEmpty || pCont.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all the fields")),
      );
      return;
    }

    String? result = await authService.login(
      email: eCont.text,
      password: pCont.text,
    );
    

    if (result == null) {
      // SUCCESS: result is null, user successfully created
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Log in Successful!")),
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
      backgroundColor: Colors.white, // Consistent white background
      body: SafeArea(
        child: SingleChildScrollView(
          // Prevents overflow on small screens
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to left
              children: [
                const SizedBox(height: 40),

                // Header Text (Matching Signup Screen Style)
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Please login to your account",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 40),

                // Email Input - Enhanced with Rounded Borders
                TextField(
                  controller: eCont,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email Address",
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

                // Password Input - Enhanced with Rounded Borders
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

                const SizedBox(height: 15),

                // Forgot Password Link (Optional but good for UX)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Login Button - Black Style like "SHOP NOW"
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Matches the dark theme
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "LOG IN",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Sign Up Link Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign Up",
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
