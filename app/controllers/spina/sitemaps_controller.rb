class Spina::SitemapsController < Spina::ApplicationController
  
  def show
    I18n.locale = I18n.default_locale
    @pages = current_account.pages.live.sorted
  end
  
end
