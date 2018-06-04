class PagesController < ApplicationController
  def home
    @game = Game.last
  end
end
