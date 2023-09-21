import 'package:codegen/codegen.dart';
import 'package:puppeteer/puppeteer.dart';

@NomoCode()
class Input {
  final String label;
  final ElementHandle handle;
  final ElementHandle? maxHandle;
  final ElementHandle? multiButton;

  Input(this.label, this.handle, this.maxHandle, this.multiButton);
}

extension ExPage on Page {
  Future<void> waitForDownload(
      {Duration timeout = const Duration(minutes: 5)}) async {
    browser.onTargetChanged.listen((target) async {
      if (target.type == "page") {
        var page = await target.page;
        var contentDisposition = await page.evaluate(
            "() => document.querySelector('meta[http-equiv=\"Content-Disposition\"]')?.content");
        if (contentDisposition != null &&
            contentDisposition.startsWith('attachment')) {
          var downloadUrl = page.url;
          // Handle the download URL as needed
          print("Download triggered from URL: $downloadUrl");
        }
      }
    });
  }
}
