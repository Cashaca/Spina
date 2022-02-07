module Spina
  module Api
    class ApiController < ActionController::Base
      include Spina::CurrentAccount, Spina::CurrentTheme
      
      protect_from_forgery unless: -> { request.format.json? }
      
      rescue_from ActiveRecord::RecordNotFound, with: :render_404
      
      TOKEN = Spina.config.api_key
      
      before_action :authenticate_api
      
      private
      
        def render_404
          render json: {error: "Not Found"}, status: :not_found
        end

        def authenticate_api
          head :not_found and return if TOKEN.blank?
          authenticate_or_request_with_http_token do |token, options|
            ActiveSupport::SecurityUtils.secure_compare(token, TOKEN)
          end
        end

        def current_account
          Spina::Current.account = nil
          if params[:account_id]
            Spina::Current.account ||= ::Spina::Account.where(id: params[:account_id]).first
          else
            Spina::Account.with_domain_name_regex.each do |account|
              Spina::Current.account ||= account if request.domain =~ /#{Regexp.quote(account.domain_name_regex)}/
            end
            Spina::Current.account ||= ::Spina::Account.first
          end
          return Spina::Current.account
        end
      
    end
  end
end
