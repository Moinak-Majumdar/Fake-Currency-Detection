import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.onTap,
    required this.loading,
    required this.title,
    this.onLoadText,
    this.showDisable = false,
    this.leadingIcon,
    this.margin,
    this.borderRadius,
  });
  final void Function()? onTap;
  final bool loading;
  final String? onLoadText;
  final String title;
  final bool showDisable;
  final IconData? leadingIcon;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      height: 50,
      margin: margin,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            if (showDisable) ...[
              colorScheme.tertiaryContainer,
              colorScheme.secondaryContainer,
              colorScheme.tertiaryContainer,
            ] else ...[
              colorScheme.secondary,
              colorScheme.tertiary,
              colorScheme.secondary,
            ]
          ],
        ),
        borderRadius: borderRadius,
      ),
      child: MaterialButton(
        onPressed: loading ? null : onTap,
        height: double.infinity,
        child: loading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (onLoadText != null) ...[
                    Text(
                      onLoadText!,
                      style: TextStyle(
                        fontSize: 16,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                  Transform.scale(
                    scale: 0.6,
                    child:
                        CircularProgressIndicator(color: colorScheme.primary),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (leadingIcon != null) ...[
                    Icon(
                      leadingIcon!,
                      color: showDisable
                          ? colorScheme.primaryContainer
                          : colorScheme.tertiaryContainer,
                    ),
                    const SizedBox(width: 12),
                  ],
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: showDisable
                          ? colorScheme.primaryContainer
                          : colorScheme.tertiaryContainer,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
