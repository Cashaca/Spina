class Spina::ApplicationController < Spina.frontend_parent_controller.constantize
  include Spina.config.authentication.constantize
  include Spina::CurrentAccount, Spina::CurrentTheme
  
  helper Spina::Engine.helpers
  
  protect_from_forgery with: :exception

private

  def current_account
    puts "current_account FRONT END"
    puts "cookies[:current_account_id: #{cookies[:current_account_id]}"
    Spina::Current.account = nil
    Spina::Account.with_domain_name_regex.each do |account|
      Spina::Current.account ||= account if request.domain =~ /#{Regexp.quote(account.domain_name_regex)}/
    end
    puts "Spina::Current.account (based on domain): #{Spina::Current.account.inspect}"
    if cookies[:current_account_id]
      # set by admin when working in admin views
      Spina::Current.account ||= ::Spina::Account.where(id: cookies[:current_account_id]).first
    end
    puts "Spina::Current.account (based on cookie if no domain found): #{Spina::Current.account.inspect}"
    Spina::Current.account ||= Spina::Account.first
    Spina::Current.account.view_context = view_context
    puts "Spina::Current.account (backup): #{Spina::Current.account.inspect}"
    return Spina::Current.account
  end
end
