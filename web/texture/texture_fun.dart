import 'dart:html';
import 'dart:math';
import 'package:bot/bot.dart';
import 'package:bot/bot_html.dart';
import 'package:bot/bot_retained.dart';
import 'package:bot/bot_texture.dart';
import 'package:poppopwin/canvas.dart';
import 'package:poppopwin/poppopwin.dart';
import '../texture_data.dart';

const String _transparentTextureName = '../images/transparent_animated.png';
const String _opaqueTextureName = '../images/dart_opaque_01.jpg';
const String _transparentStaticTexture = '../images/transparent_static.png';

ImageLoader _imageLoader;
List<String> _keys;
int _currentIndex = 0;
CanvasRenderingContext2D __ctx;
TextureData _textureData;

main() {
  _imageLoader = new ImageLoader([_transparentTextureName, _opaqueTextureName,
                                  _transparentStaticTexture]);
  _imageLoader.loaded.add((args) => _doLoad());
  _imageLoader.load();
}

_doLoad() {
  final opaqueImage = _imageLoader.getResource(_opaqueTextureName);
  final transparentImage = _imageLoader.getResource(_transparentTextureName);
  final staticTransparentImage = _imageLoader.getResource(_transparentStaticTexture);

  final textures = getTextures(transparentImage, opaqueImage, staticTransparentImage);
  _textureData = new TextureData(textures);

  CanvasElement canvasElement = query('#textureCanvas');
  canvasElement.on.click.add((args) => _next());
  __ctx = canvasElement.context2d;

  _keys = new List<String>.from(textures.keys);

  _drawTexture();

  window.on.keyDown.add((KeyboardEvent args) {
    switch(args.keyCode) {
      case KeyCode.RIGHT:
        _next();
        break;
      case KeyCode.LEFT:
        _previous();
        break;
    }
  });
}

void _next() {
  _currentIndex++;
  _drawTexture();
}

void _previous() {
  _currentIndex--;
  _drawTexture();
}

void _drawTexture() {
  _currentIndex %= _keys.length;

  __ctx.clearRect(0, 0, 700, 700);

  assert(_keys != null);

  final key = _keys[_currentIndex];

  final texture = _textureData.getTexture(key);

  print([_currentIndex, key]);

  _textureData.drawTextureAt(__ctx, new Coordinate(100, 100), texture);

}
