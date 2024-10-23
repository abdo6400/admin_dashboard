import 'package:admin/core/utils/app_sizes.dart';
import 'package:flutter/material.dart';

class SettingsGroup extends StatelessWidget {
  final String? settingsGroupTitle;
  final TextStyle? settingsGroupTitleStyle;
  final List<SettingsItem> items;
  final IconData? icon;
  const SettingsGroup(
      {super.key,
      this.settingsGroupTitle,
      this.settingsGroupTitleStyle,
      required this.items,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (settingsGroupTitle != null)
            ? Card(
                elevation: 0,
                child: Container(
                  width: context.screenWidth,
                  padding: EdgeInsets.symmetric(
                      horizontal: context.paddingWidth * 10,
                      vertical: context.paddingHeight * 5),
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        color: Theme.of(context).hintColor,
                      ),
                      SizedBox(
                        width: context.paddingWidth * 10,
                      ),
                      Text(
                        settingsGroupTitle!,
                        style: (settingsGroupTitleStyle == null)
                            ? Theme.of(context).textTheme.titleLarge
                            : settingsGroupTitleStyle,
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return items[index];
            },
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const ScrollPhysics(),
          ),
        ),
      ],
    );
  }
}

class SettingsItem extends StatelessWidget {
  final Icon? icon;
  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final int? titleMaxLine;
  final int? subtitleMaxLine;
  final TextOverflow? overflow;

  const SettingsItem(
      {super.key,
       this.icon,
      required this.title,
      this.titleStyle,
      this.subtitle,
      this.subtitleStyle,
      this.backgroundColor,
      this.trailing,
      this.onTap,
      this.titleMaxLine,
      this.subtitleMaxLine,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(context.radius * 15),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.radius * 15),
        ),
        leading:icon!=null? Material(
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.radius * 10)),
          color: backgroundColor,
          child: Padding(
            padding: EdgeInsets.all(context.radius * 5),
            child: icon,
          ),
        ):null,
        title: Text(
          title,
          style: titleStyle,
          maxLines: titleMaxLine,
          overflow: titleMaxLine != null ? overflow : null,
        ),
        subtitle: (subtitle != null)
            ? Text(
                subtitle!,
                style: subtitleStyle ?? Theme.of(context).textTheme.bodySmall!,
                maxLines: subtitleMaxLine,
                overflow:
                    subtitleMaxLine != null ? TextOverflow.ellipsis : null,
              )
            : null,
        trailing:
            (trailing != null) ? trailing : const Icon(Icons.navigate_next),
      ),
    );
  }
}
