window.onload = ->
  @game = new Phaser.Game(window.innerWidth, window.innerHeight, Phaser.AUTO)

  # States
  @game.state.add 'menu', new MenuState
  @game.state.add 'loading', new LoadingState, true
