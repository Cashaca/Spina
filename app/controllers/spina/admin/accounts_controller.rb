module Spina
  module Admin
    class AccountsController < AdminController
      before_action :set_account, only: [:edit, :update, :destroy]

      admin_section :settings
      
      def index
        @accounts = Spina::Account.order(:name)
        add_breadcrumb I18n.t('spina.preferences.accounts'), spina.admin_accounts_path
      end

      def select
        account = Account.find(params[:id])
        select_new_current_account(account)
        flash[:success] = I18n.t('spina.accounts.selected', account: account.name)
        redirect_to admin_accounts_url
      end

      def new
        @account = Account.new
        add_index_breadcrumb
        add_breadcrumb I18n.t('spina.accounts.new')
      end

      def create
        @account = Account.new(account_params)
        @account.theme = Theme.all.first.name
        if @account.save
          select_new_current_account(@account)
          redirect_to admin_accounts_url
        else
          flash.now[:alert] = I18n.t('spina.accounts.cannot_be_created')
          add_index_breadcrumb
          add_breadcrumb I18n.t('spina.accounts.new')
          render :new, status: :unprocessable_entity
        end
      end

      def edit
        add_index_breadcrumb
        add_breadcrumb "#{@account}"
      end

      def update
        if @account.update(account_params)
          redirect_to spina.admin_accounts_path
        else
          flash.now[:error] = t('spina.accounts.couldnt_be_saved')
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        if @account != current_account
          @account.destroy
          redirect_to spina.admin_accounts_url, flash: {success: t('spina.accounts.deleted')}
        end
      end

      private

        def account_params
          params.require(:account).permit!
        end

        def add_index_breadcrumb
          add_breadcrumb I18n.t('spina.preferences.accounts'), spina.admin_accounts_path, class: 'text-gray-400'
        end

        def set_account
          @account = Account.find(params[:id])
        end

    end
  end
end
