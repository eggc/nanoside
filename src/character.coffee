Grid = require('grid')
Tween = require('./tween')
Config = require('./config')
Flag = require('./flag')
base = [
   99, 102, 105, 108,
  179, 182, 185, 188,
  259, 262, 265, 268,
  339, 342, 345, 348
]

module.exports = class Character extends Grid.Piece
  @include(require('./shape'))

  constructor: (options)->
    super
    @shape = new createjs.Container()
    @sprite = new createjs.Sprite(@_createSheet(options.spriteNumber), "down")
    @flag   = new Flag(@teamCode)
    @shape.addChild(@sprite)
    @shape.addChild(@flag.getShape())

  tweenPosition: (position) ->
    dir = @getPosition().where(position)
    @sprite.gotoAndPlay(dir)
    Tween.tweenPosition.apply(@, arguments)

  damage: ->
    super
    if @isDead()
      @sprite.gotoAndStop('defeated')

  _createSheet: (spriteNumber)->
    code = base[spriteNumber]
    new createjs.SpriteSheet
      images: [Config.Sprite.PATH]
      frames: { width: Config.CELL_WIDTH, height: Config.CELL_WIDTH }
      animations:
        down:  { frames: [code + 0,  code + 1,  code + 2,  code + 1],  speed: Config.Sprite.FRAME_SPEED }
        up:    { frames: [code + 16, code + 17, code + 18, code + 17], speed: Config.Sprite.FRAME_SPEED }
        left:  { frames: [code + 32, code + 33, code + 34, code + 33], speed: Config.Sprite.FRAME_SPEED }
        right: { frames: [code + 48, code + 49, code + 50, code + 49], speed: Config.Sprite.FRAME_SPEED }
        defeated: code - 16
