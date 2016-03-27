class SessionsController < ApplicationController
  def new
  end

  def create
    usuario = Usuario.find_by(email: params[:session][:email].downcase)
    if usuario && usuario.authenticate(params[:session][:password])
      log_in usuario
      redirect_to usuario.gerente? ? informes_path : salida_parqueos_path
    else
      flash.now[:danger] = 'El email y/o el password son inválidos'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end

  private
    def log_in(user)
      session[:user_id] = user.id
    end

    def log_out
      session.delete(:user_id)
      @current_user = nil
    end
end
