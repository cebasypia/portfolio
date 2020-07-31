class Api::V1::GamesController < ApiController
  before_action :authenticate_user

  def get_score
    score = {}
    score[:correct_answer] = Language.get_data(params[:text])
    render json: score
  end
end
