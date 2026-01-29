import 'package:flutter/material.dart';

/// Breakpoint widths for responsive layout
const double kTabletBreakpoint = 600;
const double kDesktopBreakpoint = 900;

/// Returns true if the current width is tablet or larger
bool isTabletOrLarger(BuildContext context) {
  return MediaQuery.sizeOf(context).width >= kTabletBreakpoint;
}

/// Returns true if the current width is desktop or larger
bool isDesktopOrLarger(BuildContext context) {
  return MediaQuery.sizeOf(context).width >= kDesktopBreakpoint;
}

/// Number of columns for country list grid on tablet+
int listGridCrossAxisCount(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  if (width >= kDesktopBreakpoint) return 3;
  if (width >= kTabletBreakpoint) return 2;
  return 1;
}
