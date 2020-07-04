class Api::V1::SessionsController < ApiController
  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      log_in user
      render json: user
    else
      # エラーメッセージを作成する
      render json: { errors: ["Invalid email/password combination"] }, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    head :no_content
  end

  def logged_in
    render json: current_user
  end
end
