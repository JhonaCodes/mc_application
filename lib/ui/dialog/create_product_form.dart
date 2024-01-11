import 'dart:developer';

import 'package:deepstatemanagment/model/product.dart';
import 'package:deepstatemanagment/provider/products_provider.dart';
import 'package:deepstatemanagment/provider/state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:text_field_validation/text_field_validation.dart';
import 'package:uuid/uuid.dart';

class CreateProductForm extends ConsumerWidget {

  CreateProductForm({super.key});

  final _formKeu = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _attributeController = TextEditingController();
  final TextEditingController _currencyController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    /// Ugly way to get the state of the provider, just for the example.
    final creating = ref.watch(creatingState.notifier);

    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: const Text('Add product'),
          content: Form(
            key: _formKeu,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  TextFormValue(
                    controller: _nameController,
                    label: 'Name',
                    onValidate: (value) => value != null ? null : "Name is required",
                  ),
                  TextFormValue(
                    onValidate: (value)=> value != null ? null : "Attribute is required",
                    label: 'Attribute',
                    controller: _attributeController,
                  ),

                  TextFormValue(
                    onValidate: (value)=> TextFieldValidation.alphanumeric(value!),
                    label: 'Currency',
                    controller: _currencyController,
                  ),

                  TextFormValue(
                    onValidate: (value)=> TextFieldValidation.alphanumeric(value!),
                    label: 'Unit',
                    controller: _unitController,

                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text('Cancel')
            ),
            TextButton(
                onPressed: ()async{

                  /// A simple implementation for create a product.
                  ///
                  /// Just for the example.
                  if(_formKeu.currentState!.validate()){

                    try {
                      creating.setCreating(StateProviderType.creating);

                      /// So the provider is not reloaded, we use the read method.
                      ref.watch(addProduct(
                          Product(
                            id: const Uuid().v4().toString(),
                            name: _nameController.text,
                            attribute: _attributeController.text,
                            currency: _currencyController.text,
                            unit: _unitController.text,
                          )
                      ));

                      _clean();

                      /// use showSnackBar
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Product added', style: TextStyle(color: Colors.white),),
                          ),
                      );

                    } catch (e) {
                      log(e.toString());
                      creating.setCreating(StateProviderType.error );
                    }

                  }

                  creating.setCreating ( StateProviderType.created );

                  Navigator.maybePop(context);

                  setState((){});
                },
                child: creating.isCreated ? const Text('Agregar') : const CircularProgressIndicator()
            ),
          ],
        );
      }
    );
  }

  void _clean(){
    _nameController.clear();
    _attributeController.clear();
    _currencyController.clear();
    _unitController.clear();
  }
}


class TextFormValue extends StatelessWidget {
  final String label;
  final Function(String?) onValidate;
  final TextEditingController controller;
  const TextFormValue({super.key, required this.label, required this.onValidate, required this.controller});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: controller,
      validator: (value)=> onValidate(value!),
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}
