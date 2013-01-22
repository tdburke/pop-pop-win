import 'dart:io';
import 'dart:json';

main() {
  HttpServer app = new HttpServer();

  app.addRequestHandler(
    (req) => req.method == 'GET' && req.path == '/',
    (req, res) {
      var file = new File('../web/index.html');
      var stream = file.openInputStream();
      stream.pipe(res.outputStream);
    }
  );
  
  var port = int.parse(Platform.environment['PORT']);

  app.listen('0.0.0.0', port);
}


