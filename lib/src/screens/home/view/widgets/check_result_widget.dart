import 'package:flutter/material.dart';
// import 'package:rachaconta/src/core/widgets/action_button.dart';

class CheckResultScreen extends StatefulWidget {
  final double totalPrice;
  final double individualPrice;
  final double priceWhoDrank;
  final double waiterValue;

  const CheckResultScreen({
    Key? key,
    required this.totalPrice,
    required this.individualPrice,
    required this.priceWhoDrank,
    required this.waiterValue,
  }) : super(key: key);

  @override
  State<CheckResultScreen> createState() => _CheckResultScreenState();
}

class _CheckResultScreenState extends State<CheckResultScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    // TextStyle resultTextStyle = const TextStyle();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado da Conta'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        toolbarHeight: size.height * 0.06837606837606838,
        // titleSpacing: 30,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Divider(
              thickness: 10,
              color: Color.fromARGB(255, 26, 163, 124),
              //  height: 40,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(size.height * 0.02),
              child: Text(
                '🙂 Não bebeu, paga: R\$${widget.individualPrice.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            if (widget.priceWhoDrank > 0) ...{
              const Divider(),
              Padding(
                padding: EdgeInsets.all(size.height * 0.02),
                child: Text(
                  ' 🥃 Se bebeu, paga: R\$${widget.priceWhoDrank.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            },
            const Divider(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.all(size.height * 0.02),
              child: Text(
                '🤵🏽 Gorjeta: R\$${widget.waiterValue.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.red,
                      fontSize: 20,
                    ),
              ),
            ),
            const Divider(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.all(size.width * 0.005),
              child: Text(
                'Valor total: R\$${widget.totalPrice.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.green,
                      fontSize: 23,
                    ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Divider(
              height: 20,
              thickness: 10,
              color: Colors.red,
            ),
            Padding(
              padding: EdgeInsets.all(size.height * 0.02),
              child: Text(
                'Compartilhe a conta',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.abc), // era whats
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.facebook),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.email),
                ),
              ],
            ),
            const Divider(
              height: 40,
              thickness: 10,
              color: Colors.red,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Registrar este momento? ',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 11,
                      ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Entre/Registre-se!',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.red,
                          fontSize: 11,
                        ),
                  ),
                ),
              ],
            ),

            // const Divider(),
            // Padding(
            //   padding: EdgeInsets.all(size.height * 0.02),
            //   child: Text(
            //     'Compartilhe a  a conta com seus amigos?',
            //     style: Theme.of(context).textTheme.headline6,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
