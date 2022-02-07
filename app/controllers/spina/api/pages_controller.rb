module Spina
  module Api
    class PagesController < ApiController
      include Paginable
      
      before_action :set_resource
      
      def index
        pages = current_account.pages.live.includes(:translations).where(resource: @resource).order(:created_at)
        render json: Spina::Api::PageSerializer.new(*pagination(pages)).serializable_hash.to_json
      end
      
      def show
        @page = current_account.pages.live.where(resource: @resource).find(params[:id])
        render json: Spina::Api::PageSerializer.new(@page).serializable_hash.to_json
      end
      
      private
      
        def set_resource
          @resource = Spina::Resource.find(params[:resource_id]) if params[:resource_id].present?
        end

    end
  end
end
