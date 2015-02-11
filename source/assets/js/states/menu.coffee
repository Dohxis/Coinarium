class MenuState extends Phaser.State
  constructor: -> super

  preload: ->

  create: ->
    #Blue   > #030B2D
    #Yellow > #FAB91E
    @game.stage.backgroundColor = '#030B2D'

    #@logo = new LogoSprite(@game, @game.world.centerX, @game.world.centerY, 'logo')
    #@game.world.add(@logo)
