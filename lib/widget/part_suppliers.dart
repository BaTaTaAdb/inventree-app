import 'package:inventree/l10.dart';

import 'package:inventree/api.dart';

import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventree/inventree/part.dart';
import 'package:inventree/inventree/company.dart';
import 'package:inventree/widget/refreshable_state.dart';

class PartSupplierWidget extends StatefulWidget {

  PartSupplierWidget(this.part, {Key? key}) : super(key: key);

  final InvenTreePart part;

  @override
  _PartSupplierState createState() => _PartSupplierState(part);

}


class _PartSupplierState extends RefreshableState<PartSupplierWidget> {

  _PartSupplierState(this.part);

  final InvenTreePart part;

  List<InvenTreeSupplierPart> _supplierParts = [];

  @override
  Future<void> request() async {
    // TODO - Request list of suppliers for the part
    await part.reload();
    _supplierParts = await part.getSupplierParts();
  }

  @override
  String getAppBarTitle(BuildContext context) => L10().partSuppliers;

  @override
  List<Widget> getAppBarActions(BuildContext contexts) {
    // TODO
    return [];
  }

  Widget _supplierPartTile(BuildContext context, int index) {

    InvenTreeSupplierPart _part = _supplierParts[index];

    return ListTile(
      leading: InvenTreeAPI().getImage(
        _part.supplierImage,
        width: 40,
        height: 40,
      ),
      title: Text("${_part.SKU}"),
      subtitle: Text("${_part.manufacturerName}: ${_part.MPN}")
    );
  }

  @override
  Widget getBody(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      separatorBuilder: (_, __) => const Divider(height: 3),
      itemCount: _supplierParts.length,
      itemBuilder: _supplierPartTile,
    );
  }

}