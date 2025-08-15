import 'package:STTS/Constants/stts_uganda_exports.dart';
import 'package:get/get.dart';

class Scan extends StatelessWidget {
  const Scan({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track & Trace'),
      ),
      body: FormBuilder(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'lot_number',
                autofocus: true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    // context,
                    errorText: "Lot number is required.",
                  ),
                ]),
                decoration: InputDecoration(
                    labelText: "Lot number",
                    labelStyle: MyText.caption(context)),
              ),
              const SizedBox(
                height: 100,
              ),
              FxButton.block(
                borderRadiusAll: 0,
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    Utils.showSnackBar(
                        "Please Check errors in the form and fix them first.",
                        context,
                        background_color: Colors.red);
                  } else {
                    Get.to(ScanningScreen(
                      lotNumber:
                          _formKey.currentState?.fields['lot_number']?.value,
                    ));
                  }
                },
                backgroundColor: CustomTheme.primary,
                child: FxText(
                  "SUBMIT",
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
