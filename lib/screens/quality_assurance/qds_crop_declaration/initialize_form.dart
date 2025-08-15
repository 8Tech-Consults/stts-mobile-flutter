import 'package:STTS/Constants/stts_uganda_exports.dart';
import 'package:STTS/controllers/planting_controller.dart';
import 'package:STTS/models/updateCropDeclaration.dart';

class InitializeCropInspection extends StatefulWidget {
  final int? qdsId;
  const InitializeCropInspection({super.key, this.qdsId});

  @override
  State<InitializeCropInspection> createState() =>
      _InitializeCropInspectionState();
}

class _InitializeCropInspectionState extends State<InitializeCropInspection> {
  int? selectedOption;
  PlantingController plantingController = PlantingController();
  UpdateCropDeclaration updateCropDeclaration =
      UpdateCropDeclaration(status: 16);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: plantingController,
      child: Consumer<PlantingController>(
        builder: (_, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('QDS Crop Declaration'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Status",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          title: const Text('Initialize'),
                          leading: Radio(
                            value: 16,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value!;
                              });
                            },
                          ),
                        ),
                      ]),
                  const SizedBox(
                    height: 100,
                  ),
                  if (model.isLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      ),
                    ),
                  if (!model.isLoading)
                    FxButton.block(
                      borderRadiusAll: 0,
                      onPressed: () {
                        model.updateQDSDeclaration(
                            updateCropDeclaration, widget.qdsId);
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
          );
        },
      ),
    );
  }
}
