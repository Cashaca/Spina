class Spina::ApplicationController < Spina.frontend_parent_controller.constantize
  include Spina.config.authentication.constantize
  include Spina::CurrentAccount, Spina::CurrentTheme
  
  helper Spina::Engine.helpers
  
  protect_from_forgery with: :exception

private

  def current_account
    Spina::Current.account = nil
    Spina::Account.with_domain_name_regex.each do |account|
      Spina::Current.account ||= account if request.domain =~ /#{Regexp.quote(account.domain_name_regex)}/
    end
    Spina::Current.account ||= Spina::Account.first
    Spina::Current.account.view_context = view_context
    return Spina::Current.account
  end
end
