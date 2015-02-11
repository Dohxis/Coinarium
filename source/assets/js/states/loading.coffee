class LoadingState extends Phaser.State
  constructor: -> super

  preload: ->
    @game.load.image('logo', 'assets/images/logo.png')
    #@game.load.image()
    #@game.load.image()
    #@game.load.image()
    #@game.load.image()
    #@game.load.image()

  create: ->
    @game.state.start('menu')
