module Spina
  module Admin
    class AdminController < ActionController::Base
      include Spina.config.authentication.constantize
      include Spina::CurrentAccount, Spina::CurrentTheme
      
      helper Spina::Engine.helpers
      
      before_action :add_view_path
      before_action :set_admin_locale
      before_action :authenticate
      
      admin_section :content
      
      def current_admin_path
        request.fullpath[%r{/#{ Spina.config.backend_path }(.*)}, 1]
      end
      helper_method :current_admin_path

      private
      
        def render_flash
          render turbo_stream: turbo_stream.update("flash", partial: "spina/admin/shared/flash")
        end

        def set_admin_locale
          I18n.locale = I18n.default_locale
        end
        
        def add_view_path
          prepend_view_path Spina::Engine.root.join('app/views/spina/admin')
        end

        def current_account
          Spina::Current.account = nil
          if cookies[:current_account_id]
            Spina::Current.account = ::Spina::Account.where(id: cookies[:current_account_id]).first
          else
            Spina::Account.with_domain_name_regex.each do |account|
              Spina::Current.account ||= account if request.domain =~ /#{Regexp.quote(account.domain_name_regex)}/
            end
          end
          Spina::Current.account ||= ::Spina::Account.first
          return Spina::Current.account
        end

    end
  end
end
