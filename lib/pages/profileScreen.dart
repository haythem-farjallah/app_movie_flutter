import 'package:flutter/material.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromARGB(83, 107, 98, 97),
        ),
        child: Icon(icon,
            size: 20.0, color: const Color.fromARGB(255, 238, 235, 235)),
      ),
      title: Text(title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          )),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Color.fromARGB(83, 107, 98, 97),
              ),
              child: const Icon(Icons.arrow_right_rounded,
                  size: 30.0, color: Colors.grey))
          : null,
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("images/netflix.png", width: 100),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 40),
              Stack(
                children: [
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child:
                            const Image(image: AssetImage("images/man.png"))),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromARGB(255, 255, 20, 3)),
                      child: const Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 243, 238, 238),
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                "Ahmed Mokni",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 38,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "mokni.ahmed.am@gmail.com",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "53560362",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Color.fromARGB(255, 214, 143, 138)),
              ),
              const SizedBox(height: 20),

              /// -- BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () =>
                      {Navigator.pushReplacementNamed(context, '/edit')},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 224, 17, 17),
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text("Edit",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 253, 253),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      )),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(
                  title: "Settings",
                  icon: Icons.settings,
                  onPress: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  }),
              ProfileMenuWidget(
                  title: "Logout", icon: Icons.logout, onPress: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
