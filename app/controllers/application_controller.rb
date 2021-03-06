class ApplicationController < ActionController::Base

  before_action :authenticate_user!,except: [:top, :about]
  # topアクションとaboutアクションのみログアウト状態でも表示

  before_action :configure_permitted_parameters, if: :devise_controller?
  # deviseで利用出来るパラメーターを設定しますよ。という意味
  # deviceとは認証系アプリに必要な機能を簡単に追加できる便利なgem
  # :devise_contoller?とはdeviseを生成した際にできるヘルパーメソッドの一つで、deviseにまつわる画面に行った時に、という意味
  protected
  # Application Controllerを継承してるControllerも参照できる

  def after_sign_in_path_for(resource)
    # resourceに情報(user)が自動的に格納されている
    # deviseを読み込んだときにrails g devise Userと記入したため
    user_path(resource)
  end

  def after_sign_out_path_for(resource)
    root_path
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

end
