import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:zim_birds/src/purchases/purchases.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: SafeArea(
        child: Consumer<PaymentsHelper>(builder: (context, payments, _) {
          return Column(
            children: [
              Text(
                'Zimbabwe Birds',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'You can contact us through Whatsapp on +263716138432,'
                ' or email to eddie@diggle.tech',
              ),
              SizedBox(height: 38),
              if (payments.offerings != null &&
                  payments.offerings!.current != null)
                _buildOfferings(context, payments.offerings!),
              Spacer(),
              Text('© Diggle Studios ${DateTime.now().year}'),
            ],
          );
        }),
      ),
    );
  }

  _buildOfferings(BuildContext context, Offerings offerings) {
    final packages = offerings.current!.availablePackages;
    return ListView.builder(
      itemBuilder: (context, position) {
        return Container(
          child: Text(packages[position].product.title),
        );
      },
      itemCount: packages.length,
    );
  }
}
