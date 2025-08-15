import 'package:intl/intl.dart';
import '../../../Constants/stts_uganda_exports.dart';

class ScanningWigdet extends StatelessWidget {
  final Trace? trace;
  const ScanningWigdet({super.key, this.trace});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (trace?.crop != null) Text('Crop:   ${trace?.crop}'),
              if (trace?.cropVariety?.name != null)
                Text('Crop Variety:   ${trace?.cropVariety?.name}'),

              if (trace?.brokenGerms != null)
                Row(
                  children: [
                    const Text('Broken Germs:'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      trace!.brokenGerms.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              // Text('Test Decision:   ${trace?.testDecision}'),
              // Text('Mother Lot:   ${trace?.motherLot}'),

              if (trace?.collectionDate != null)
                Row(
                  children: [
                    const Text('Test Date:  '),
                    Text(
                      DateFormat('EEEE, d MMM, yyyy').format(
                        DateTime.parse(trace!.collectionDate.toString()),
                      ),
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              if (trace?.testDate != null)
                Row(
                  children: [
                    const Text('Test Date:  '),
                    Text(
                      DateFormat('EEEE, d MMM, yyyy').format(
                        DateTime.parse(trace!.testDate.toString()),
                      ),
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              if (trace?.labTestNumber != null)
                Row(
                  children: [
                    const Text('Lab test number:'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      trace!.labTestNumber.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              if (trace?.seedClass != null)
                Row(
                  children: [
                    const Text('Seed class:'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      trace!.seedClass.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

              if (trace?.germinationCapacity != null)
                Row(
                  children: [
                    const Text('Germination capacity:'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      trace!.germinationCapacity.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
