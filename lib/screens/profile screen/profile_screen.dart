import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = 'Mohammad Iqbal Abdillah';
  String _address = 'Jember-Balung-KarangSemanding';
  String _phoneNumber = '+62 812 165 309 13';
  String _email = 'example@example.com';
  String _password = 'password123';
  String? _profileImagePath; // Store the image path as a string
  Uint8List? _webImage; // Store the web image data
  bool _showPassword = false;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profile_image');
    String? name = prefs.getString('profile_name');
    String? email = prefs.getString('profile_email');
    String? password = prefs.getString('profile_password');
    String? address = prefs.getString('profile_address');
    String? phoneNumber = prefs.getString('profile_phone');

    setState(() {
      if (kIsWeb && imagePath != null) {
        _webImage = Uri.parse(imagePath).data!.contentAsBytes();
      } else {
        _profileImagePath = imagePath;
      }
      _name = name ?? _name;
      _email = email ?? _email;
      _password = password ?? _password;
      _address = address ?? _address;
      _phoneNumber = phoneNumber ?? _phoneNumber;
    });
  }

  Future<void> _saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_profileImagePath != null) {
      await prefs.setString('profile_image', _profileImagePath!);
    }
    await prefs.setString('profile_name', _name);
    await prefs.setString('profile_email', _email);
    await prefs.setString('profile_password', _password);
    await prefs.setString('profile_address', _address);
    await prefs.setString('profile_phone', _phoneNumber);
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _webImage = bytes;
          _profileImagePath = Uri.dataFromBytes(bytes).toString();
        });
      } else {
        setState(() {
          _profileImagePath = pickedFile.path;
        });
      }
      _saveProfileData();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget profileImageWidget;
    if (kIsWeb && _webImage != null) {
      profileImageWidget = ClipOval(
        child: Image.memory(
          _webImage!,
          width: 160,
          height: 160,
          fit: BoxFit.cover,
        ),
      );
    } else if (_profileImagePath != null) {
      profileImageWidget = ClipOval(
        child: Image.file(
          File(_profileImagePath!),
          width: 160,
          height: 160,
          fit: BoxFit.cover,
        ),
      );
    } else {
      profileImageWidget = Icon(
        Icons.person,
        size: 80,
        color: Colors.grey[800],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey[200],
                child: profileImageWidget,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              initialValue: _name,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
                _saveProfileData();
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              initialValue: _email,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
                _saveProfileData();
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              initialValue: _password,
              obscureText: !_showPassword,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
                _saveProfileData();
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              initialValue: _address,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _address = value;
                });
                _saveProfileData();
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              initialValue: _phoneNumber,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _phoneNumber = value;
                });
                _saveProfileData();
              },
            ),
          ],
        ),
      ),
    );
  }
}
