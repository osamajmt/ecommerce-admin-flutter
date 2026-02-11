import 'package:admin_app/constant/appcolor.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
class CustomDropDownSearch extends StatefulWidget {
  final String title;
  final List<SelectedListItem<String>> list;
  final TextEditingController selectedDropDownName;
  const CustomDropDownSearch({
    super.key,
    required this.title,
    required this.list,
    required this.selectedDropDownName,
  });

  @override
  State<CustomDropDownSearch> createState() => _CustomDropDownSearchState();
}

class _CustomDropDownSearchState extends State<CustomDropDownSearch> {
  showDropDownSearch() {
    DropDownState<String>(
      dropDown: DropDown<String>(
        isDismissible: true,
        bottomSheetTitle: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        submitButtonText: 'Save',
        clearButtonText: 'Clear',
        data: widget.list,
        onSelected: (selectedItems) {
          SelectedListItem selectedListItem = selectedItems[0];
          widget.selectedDropDownName.text = selectedListItem.data;
        },
        enableMultipleSelection: false,
        maxSelectedItems: 3,
      ),
    ).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return TextFormField(
      controller: widget.selectedDropDownName,
      cursorColor: Colors.black,
      // readOnly: widget.isReadOnly,
      onTap: () {
        FocusScope.of(context).unfocus();
        showDropDownSearch();
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: colors.surface,
        hintText:
            widget.selectedDropDownName.text == ""
                ? widget.title
                : widget.selectedDropDownName.text,
        hintStyle: TextStyle(color: colors.onSurface, fontSize: 14),
        labelText:
            widget.selectedDropDownName.text == ""
                ? widget.title
                : widget.selectedDropDownName.text,
        labelStyle: TextStyle(color: Colors.grey.shade700, fontSize: 14),
        suffixIcon: InkWell(
          child: Icon(Icons.arrow_drop_down, color: AppColor.primaryColor),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: AppColor.primaryColor, width: 1.5),
        ),
      ),
    
    );
  }
}
