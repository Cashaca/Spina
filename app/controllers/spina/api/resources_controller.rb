module Spina
  module Api
    class ResourcesController < ApiController
      include Paginable
      
      def index
        resources = current_account.resources.order(:id)
        render json: Spina::Api::ResourceSerializer.new(*pagination(resources)).serializable_hash.to_json
      end
      
      def show
        @resource = current_account.resources.find(params[:id])
        render json: Spina::Api::ResourceSerializer.new(@resource).serializable_hash.to_json
      end
      
    end
  end
end
      
