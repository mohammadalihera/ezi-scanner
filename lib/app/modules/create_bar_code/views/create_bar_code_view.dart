import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_bar_code_controller.dart';

class CreateBarCodeView extends GetView<CreateBarCodeController> {
  const CreateBarCodeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CreateBarCodeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CreateBarCodeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
