
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :now, except: [:store]
  before_action :authorize
  before_filter :set_i18n_locale_from_params

  def now
    @time = Time.now
  end

  private
  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.include?(params[:locale].to_sym)
        I18n.locale = params[:locale]
      else
        flash.now[:notice] =
        "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: "ログイン"
    end
  end

  def whitelist
    %w{store products}.include?(controller_name)
  end

# カートの識別・なければ渡す
  def current_cart
    # メソッド内からセッション毎に一つだけidを探してくる
    # sessionはsession別に判別するメソッド
    Cart.find(session[:cart_id])
    # しかし初セッションのユーザーはカート情報を持ってないので
    # 初セッションユーザーは例外としてカートを作成する

    # 以下より例外処理
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    # 以下を書くことでユーザーのセッションを残す
    session[:cart_id] = cart.id
    cart
  end


end
