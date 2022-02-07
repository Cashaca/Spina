module Spina
  module CurrentAccount
    extend ActiveSupport::Concern
    
    included do
      before_action :current_account
      helper_method :current_account
    end
  
    private

      def select_new_current_account(account)
        return if account.nil?
        cookies.permanent[:current_account_id] = account.id
      end
        
  end
end
