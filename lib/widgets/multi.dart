import 'package:ROSystem/models/bTypeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';

class Multi extends StatefulWidget {
  final List<BType> bTypeList;
  Multi({this.bTypeList});
  @override
  _MultiState createState() => _MultiState();
}

class _MultiState extends State<Multi> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Form(
        key: _formKey,
        autovalidate: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              child: MultiSelect(
                titleText: 'BUSINESS TYPES',
                textField: "name",
                dataSource: [
                  {
                    'name': "HARSH",
                    "code": "HAR",
                  }
                ],
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            RaisedButton(
              child: Text('Save'),
              color: Colors.white,
              onPressed: () {
                _onFormSaved();
              },
            )
          ],
        ),
      ),
    );
  }

  void _onFormSaved() {
    final FormState form = _formKey.currentState;
    form.save();
  }
}
