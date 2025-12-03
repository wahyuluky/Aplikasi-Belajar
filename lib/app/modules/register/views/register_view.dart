import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/register/controllers/register_controller.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';
import 'package:get/get.dart';

class RegisterView extends StatelessWidget {
  final controller = Get.put(RegisterController());

  RegisterView({super.key});

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

              // ---- Illustration ----
              Center(
                child: Image.asset(
                  "assets/IllustrationRegister.png",
                  height: 135,
                ),
              ),

              const SizedBox(height: 20),

              // ---- Title ----
              const Text(
                "Register",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Please register to login",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),

              const SizedBox(height: 20),

              // ---- Username Field ----
              Container(
                height: 39,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: controller.usernameC,
                  style: const TextStyle(fontSize: 12),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline, size: 18,),
                    border: InputBorder.none,
                    hintText: "Username",
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // ---- Email Field ----
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
                    prefixIcon: Icon(Icons.email_outlined, size: 18,),
                    border: InputBorder.none,
                    hintText: "Email",
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // ---- Password Field ----
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

              // ---- Register Button ----
              Obx(() => ElevatedButton(
                    onPressed:
                        controller.isLoading.isFalse ? controller.register : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 39),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: controller.isLoading.isFalse
                        ? const Text(
                            "Register",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )
                        : const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                  )),

              const SizedBox(height: 15),

              // ---- Footer (Sign In) ----
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have account? "),
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed(Routes.LOGIN);
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),
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
    home: RegisterView(),
    initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => RegisterView()),
      ],
  ));
}
