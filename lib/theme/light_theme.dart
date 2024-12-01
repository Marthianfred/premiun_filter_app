import 'package:premium_filter/export.dart';

ThemeData light({Color color = colorPrimary}) => ThemeData(
      useMaterial3: true,
      fontFamily: AppConstants.fontFamily,
      primaryColor: color,
      secondaryHeaderColor: colorSecondary,
      disabledColor: const Color(0xFFBABFC4),
      brightness: Brightness.light,
      hintColor: const Color(0xFF9F9F9F),
      cardColor: Colors.white,
      textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: color)),
      splashColor: colorBackground,
      scaffoldBackgroundColor: colorBackground,
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: colorBackground,
      ),
      colorScheme: ColorScheme.light(
        primary: color,
        surface: colorBackground,
        onSurface: colorBackground,
        secondary: colorSecondary,
        tertiary: colorTextTertiary,
      ),
    );
