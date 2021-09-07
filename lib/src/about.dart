import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: SafeArea(
        child: Column(
          children: [
            Text(
              'Zimbabwe Birds',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 20,),
            Text(
              'You can contact us through Whatsapp on +263716138432,'
              ' or email to eddie@diggle.tech',
            ),
            Spacer(),
            Text('© Diggle Studios ${DateTime.now().year}'),
          ],
        ),
      ),
    );
  }
}
