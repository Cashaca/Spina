module Spina::Admin
  class ParentPagesController < AdminController
    
    def index
      @resource = current_account.resources.find_by(id: params[:resource_id])
      @pages = current_account.pages.where(resource: @resource).sorted.includes(:translations)
    end
    
  end
end
