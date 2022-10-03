import 'package:flutter/material.dart';
import 'package:flutter_survey/pages/surveydetail/widget/circular_checkbox.dart';

class MultiSelection extends StatefulWidget {
  final List<SelectionModel> items;
  final ValueChanged<List<SelectionModel>> onChanged;

  MultiSelection({required this.items, required this.onChanged});

  @override
  _MultiSelectionState createState() => _MultiSelectionState();
}

class _MultiSelectionState extends State<MultiSelection> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        return Container(
          child: _buildSelection(index, context),
        );
      },
      separatorBuilder: (_, __) => const Divider(
        color: Colors.white,
        height: 0.5,
      ),
    );
  }

  Widget _buildSelection(int index, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            widget.items[index].label,
            style: Theme.of(context).textTheme.bodyText1,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        CircularCheckBox(
            isChecked: widget.items[index].isChecked,
            onTap: () {
              setState(() {
                widget.items[index].isChecked = !widget.items[index].isChecked;
              });
              widget.onChanged(
                  widget.items.where((element) => element.isChecked).toList());
            }),
      ],
    );
  }
}

class SelectionModel {
  final String id;
  final String label;
  bool isChecked = false;

  SelectionModel(this.id, this.label);

  @override
  String toString() {
    return label;
  }
}
