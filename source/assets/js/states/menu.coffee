class MenuState extends Phaser.State
  constructor: -> super

  preload: ->

  create: ->
    @logo = new LogoSprite(@game, @game.world.centerX, @game.world.centerY, 'logo')
    @game.world.add(@logo)
