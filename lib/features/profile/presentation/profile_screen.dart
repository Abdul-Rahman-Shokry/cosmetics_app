import 'package:cosmetics_app/core/utils/helper_methods.dart';
import 'package:cosmetics_app/features/auth/logic/auth_state.dart';
import 'package:cosmetics_app/features/auth/logic/login_logout_cubit.dart';
import 'package:cosmetics_app/features/auth/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_image.dart';

class ProfileScreen extends StatefulWidget {
  final String token;

  const ProfileScreen({
    super.key,
    required this.token,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = "";
  String profilePhoto = "profile_pic.png";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? "User";
      profilePhoto = prefs.getString('profilePhotoUrl') ?? "profile_pic.png";
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),

      child: Scaffold(
        body: BlocConsumer<LoginCubit, AuthState>(
          listener: (context, state) {
            if (state is LogoutSuccess){
              goTo(page: LoginScreen(), canPop: false);
            } else if (state is LogoutError){
              showMsg(state.message);
            }
          },

          builder: (context, state) {
            if (state is LogoutLoading){
              return const Center(child: CircularProgressIndicator(),);
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: 180,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0x434C6DD4), Color(0xffECA4C5)],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -50,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: AppImage(
                              profilePhoto,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 65),
                  Text(
                    username,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        _buildProfileOption(
                          context: context,
                          icon: "edit_info.svg",
                          title: "Edit Info",
                          onTap: (){},
                        ),
                        _buildProfileOption(
                          context: context,
                          icon: "order_history.svg",
                          title: "Order History",
                          onTap: (){},
                        ),
                        _buildProfileOption(
                          context: context,
                          icon: "wallet.svg",
                          title: "Wallet",
                          onTap: (){},
                        ),
                        _buildProfileOption(
                          context: context,
                          icon: "settings.svg",
                          title: "Settings",
                          onTap: (){},
                        ),
                        _buildProfileOption(
                          context: context,
                          icon: "voucher.svg",
                          title: "Voucher",
                          onTap: (){},
                        ),
                        _buildProfileOption(
                          context: context,
                          icon: "logout.svg",
                          title: "Logout",
                          isLogout: true,
                          onTap: (){
                            context.read<LoginCubit>().logout(widget.token);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required BuildContext context,
    required String icon,
    required String title,
    bool isLogout = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          children: [
            AppImage(
              icon,
              width: 24,
              height: 24,
              color: isLogout ? Colors.red : AppColors.primaryText,
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isLogout ? Colors.red : AppColors.primaryText,
              ),
            ),
            const Spacer(),
            if (!isLogout) AppImage('arrow-right.svg', width: 24, height: 24),
          ],
        ),
      ),
    );
  }
}
