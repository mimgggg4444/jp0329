import 'package:flutter/material.dart';
import '../navigation_state.dart';
import 'package:bottomnavigationv1/controllers/user_controller.dart';
import '../widgets/text_field_with_controller.dart';
import '../widgets/user_box.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.navigationState});

  final NavigationState navigationState;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _guardianController = TextEditingController();
  final TextEditingController _systolicController = TextEditingController();
  final TextEditingController _diastolicController = TextEditingController();
  final TextEditingController _bloodSugarController = TextEditingController();

  final UserController _userController = UserController();

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _guardianController.dispose();
    _systolicController.dispose();
    _diastolicController.dispose();
    _bloodSugarController.dispose();
    super.dispose();
  }

  Future<void> _saveToFirestore() async {
    await _userController.saveUserData(
      _nameController.text,
      _idController.text,
      int.tryParse(_ageController.text) ?? 0,
      int.tryParse(_weightController.text) ?? 0,
      _guardianController.text,
      int.tryParse(_systolicController.text) ?? 0,
      int.tryParse(_diastolicController.text) ?? 0,
      int.tryParse(_bloodSugarController.text) ?? 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: UserBox(
            nameController: _nameController,
            idController: _idController,
            ageController: _ageController,
            weightController: _weightController,
            guardianController: _guardianController,
            systolicController: _systolicController,
            diastolicController: _diastolicController,
            bloodSugarController: _bloodSugarController,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveToFirestore,
        child: const Icon(Icons.save),
      ),
    );
  }


  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Padding(
        padding: EdgeInsets.only(left: 27),
        child: Text(
          '내 정보',
          style: TextStyle(fontSize: 50.0),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 27.0),
          child: CircleAvatar(
            backgroundColor: const Color(0xFFEFEFEF),
            radius: 22.5,
            child: const Icon(
              Icons.notifications,
              color: Color(0xFF8E8B8B),
              size: 22.0,
            ),
          ),
        ),
      ],
    );
  }



  Widget _buildUserBox(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double bottomNavBarHeight =
        MediaQuery.of(context).padding.bottom + kBottomNavigationBarHeight;
    final double appBarHeight = AppBar().preferredSize.height;

    return Container(
      height: screenHeight - appBarHeight - bottomNavBarHeight,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListView(
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
          bottom: bottomNavBarHeight + 70.0,
        ),
        children: [
          Row(
            children: [
              Expanded(
                child: _buildTextFieldWithLabel('이름', '이름을 입력하세요'),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _buildTextFieldWithLabel('고유번호', '고유번호를 입력하세요'),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: _buildTextFieldWithLabel('나이', '나이를 입력하세요',
                    keyboardType: TextInputType.number),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _buildTextFieldWithLabel('체중', '체중을 입력하세요',
                    keyboardType: TextInputType.number),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          _buildTextFieldWithLabel('나의 보호자', '보호자 이름을 입력하세요'),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: _buildTextFieldWithLabel('수축기', '수축기를 입력하세요',
                    keyboardType: TextInputType.number),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _buildTextFieldWithLabel('이완기', '이완기를 입력하세요',
                    keyboardType: TextInputType.number),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          _buildTextFieldWithLabel('혈당', '혈당 수치를 입력하세요',
              keyboardType: TextInputType.number),
        ],
      ),
    );
  }

  Widget _buildTextFieldWithLabel(
      String label,
      String hintText, {
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          width: 500,
          height: 35,
          child: TextField(
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }



}