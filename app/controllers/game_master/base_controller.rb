class GameMaster::BaseController < ApplicationController
  before_action :authenticate_game_master!
end
