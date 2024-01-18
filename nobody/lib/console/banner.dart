// banner and footer has "works for you" in yellow
import 'package:coco/coco.dart';
import 'package:nobody/references.dart';

const banner = r"""
                        __              __      
           ____  ____  / /_  ____  ____/ /_  __
          / __ \/ __ \/ __ \/ __ \/ __  / / / /
         / / / / /_/ / /_/ / /_/ / /_/ / /_/ / 
        /_/ /_/\____/_.___/\____/\__,_/\__, / """;

const footer =
    '        \u001b[33mWORKS FOR Y🌘U                \u001b[0m/____/  ';

void showBanner() {
  Show.banner(banner.inColourfulChars, footer);
  Show.credits(
      'DEVELOPED BY', 'AGHIL MOHANDAS', 'FOR', 'ALMANSOORI WIRELINE SERVICES');
}
