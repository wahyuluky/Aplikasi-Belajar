import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              // --- Illustration Image ---
              Center(
                child: Image.asset(
                  "assets/IllustrationLogin.png", // sesuaikan dengan asset Anda
                  height: 135,
                ),
              ),

              const SizedBox(height: 20),

              // --- Login Title ---
              const Text(
                "Login",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Please sign in to continue",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 20),

              // --- Username Field ---
              Container(
                height: 39,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: controller.emailC,
                  style: const TextStyle(fontSize: 12),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline, size: 18,),
                    border: InputBorder.none,
                    hintText: "Email",
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // --- Password Field ---
              Container(
                height: 39,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: controller.passwordC,
                  style: const TextStyle(fontSize: 12),
                  obscureText: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline, size: 18,),
                    border: InputBorder.none,
                    hintText: "Password",
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              // --- Login Button ---
              Obx(() => ElevatedButton(
                    onPressed:
                        controller.isLoading.isFalse ? controller.login : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 39),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: controller.isLoading.isFalse
                        ? const Text("Login",
                            style: TextStyle(fontSize: 14, color: Colors.white))
                        : const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                  )),

              const SizedBox(height: 15),

              // --- Footer (Sign Up) ---
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have account? "),
                    GestureDetector(
                      onTap: () {
                        // contoh navigasi
                        Get.offAllNamed(Routes.REGISTER);
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginView(),
  ));
}


