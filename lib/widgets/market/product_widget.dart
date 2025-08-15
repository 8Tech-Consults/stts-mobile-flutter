import '../../Constants/stts_uganda_exports.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 15.0,
            spreadRadius: 0.5,
            offset: const Offset(
              3.0,
              3.0,
            ),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  Constants.imageUrl + product.productItem.imageUrl.toString(),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              product.productItem.name.toString(),
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Text(
              product.seller.toString(),
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Text(
              "${product.productItem.quantity.toString()} kgs",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
