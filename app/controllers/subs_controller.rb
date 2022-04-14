class SubsController < ApplicationController
    before_action :authenticate_user!

    def index
        @subs = Sub.all
    end

    def new
    end
    
    def create
    end

    def edit
    end

    def update
    end

    private
end
