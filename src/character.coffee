Grid = require('grid')
Tween = require('./tween')
Config = require('./config')
base = [
   99, 102, 105, 108,
  179, 182, 185, 188,
  259, 262, 265, 268,
  339, 342, 345, 348
]

module.exports = class Character extends Grid.Piece
  @include(require('./shape'))

  constructor: ->
    sheetNum = Math.floor(Math.random() * base.length)
    @shape = new createjs.Sprite(@_createSheet(sheetNum), "down")
    super

  tweenPosition: (position) ->
    dir = @getPosition().where(position)
    @shape.gotoAndPlay(dir)
    Tween.tweenPosition.apply(@, arguments)

  damage: ->
    @shape.gotoAndStop('defeated')
    super

  _createSheet: (id)->
    code = base[id]
    new createjs.SpriteSheet
      images: [Config.Sprite.PATH]
      frames: { width: Config.CELL_WIDTH, height: Config.CELL_WIDTH }
      animations:
        down:  { frames: [code + 0,  code + 1,  code + 2,  code + 1],  speed: Config.Sprite.FRAME_SPEED }
        up:    { frames: [code + 16, code + 17, code + 18, code + 17], speed: Config.Sprite.FRAME_SPEED }
        left:  { frames: [code + 32, code + 33, code + 34, code + 33], speed: Config.Sprite.FRAME_SPEED }
        right: { frames: [code + 48, code + 49, code + 50, code + 49], speed: Config.Sprite.FRAME_SPEED }
        defeated: code - 16
