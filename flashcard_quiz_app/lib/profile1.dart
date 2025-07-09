import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(debugShowCheckedModeBanner: false, home: EditableProfileScreen()),
);

class EditableProfileScreen extends StatefulWidget {
  const EditableProfileScreen({super.key});

  @override
  State<EditableProfileScreen> createState() => _EditableProfileScreenState();
}

class _EditableProfileScreenState extends State<EditableProfileScreen> {
  final TextEditingController _nameController = TextEditingController(
    text: "Charlie Chaplin",
  );
  final TextEditingController _birthdayController = TextEditingController(
    text: "Birthday",
  );
  final TextEditingController _phoneController = TextEditingController(
    text: "123 456 789",
  );
  final TextEditingController _instagramController = TextEditingController(
    text: "Instagram account",
  );
  final TextEditingController _emailController = TextEditingController(
    text: "info@ccp.co",
  );
  final TextEditingController _passwordController = TextEditingController(
    text: "Password",
  );

  bool _obscurePassword = true;
  bool _isEditing = false; // Initially not editable

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Gradient background
            Container(
              height: 240,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),

            // Scrollable content
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Column(
                    children: [
                      // Profile picture
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 46,
                          backgroundColor: Colors.purple[100],
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Edit Your Info",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Editable fields
                      ProfileInputField(
                        icon: Icons.person,
                        controller: _nameController,
                      ),
                      ProfileInputField(
                        icon: Icons.cake,
                        controller: _birthdayController,
                      ),
                      ProfileInputField(
                        icon: Icons.phone,
                        controller: _phoneController,
                      ),
                      ProfileInputField(
                        icon: Icons.camera_alt,
                        controller: _instagramController,
                      ),
                      ProfileInputField(
                        icon: Icons.email,
                        controller: _emailController,
                      ),
                      PasswordField(
                        controller: _passwordController,
                        obscure: _obscurePassword,
                        onToggle: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),

                      SizedBox(height: 20),

                      // Buttons row: Edit profile and Save
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          children: [
                            // Edit Profile Button
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.purpleAccent,
                                      Colors.deepPurple,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Edit mode enabled!"),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Edit profile",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10), // Space between buttons
                            // Save Button
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.deepPurple,
                                      Colors.purpleAccent,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_isEditing) {
                                        // Save logic here if needed
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text("Profile saved!"),
                                          ),
                                        );
                                      }
                                      _isEditing =
                                          !_isEditing; // Toggle edit mode
                                    });
                                  },
                                  child: Text(
                                    _isEditing
                                        ? "Save Changes"
                                        : "Edit Profile",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),

            // Back button
            SafeArea(
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Text input field widget
class ProfileInputField extends StatelessWidget {
  final IconData icon;
  final TextEditingController controller;
  final bool _isEditing = false; // Initially not editable

  const ProfileInputField({
    super.key,
    required this.icon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 6),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.purple),
          SizedBox(width: 15),
          Expanded(
            child: TextField(
              readOnly: !_isEditing,
              controller: controller,
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}

// Password input field with toggle
class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure;
  final VoidCallback onToggle;

  const PasswordField({
    super.key,
    required this.controller,
    required this.obscure,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 6),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.lock, color: Colors.purple),
          SizedBox(width: 15),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscure,
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
          IconButton(
            onPressed: onToggle,
            icon: Icon(
              obscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
