class PagesController < ApplicationController
  skip_before_action :authenticate_game_master!, only: [:home]

  def home
    @game = Game.last
  end
end
