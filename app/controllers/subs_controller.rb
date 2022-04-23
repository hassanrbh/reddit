class SubsController < ApplicationController
    before_action :authenticate_user!
    before_action :clarify_user!, only: [:edit, :update]

    def index 
        if !params[:q].present?
            @subs = Sub.page(params[:page]).per(4)
        else
            @sub = Sub.where("title LIKE '%#{sanitize_sql(params[:q])}%'").page(params[:page])
        end
    end

    def show
        @sub = Sub.friendly.find(params[:id])
        if params[:id] != @sub.slug
            return redirect_to @sub, :status => :moved_permanently
        end
    end

    def new
        @sub = Sub.new
        render :new
    end

    def subscribe
        @sub = Sub.find(params[:id])
        if !@sub.subscriptors.include?(current_user.id)
            @sub.subscriptors << current_user.id
            @sub.save!
            redirect_to subs_path
        else
            flash[:notice] = "Subscription has already been did"
            redirect_to subs_path
        end
    end

    def search
        if params[:search].present?
            @subs = Sub.where("title ILIKE '%#{params[:search]}%'")
            @posts = Post.where("title ILIKE '%#{params[:search]}%'")
        else
            @subs = []
            @posts = []
        end
        respond_to do |format|
            format.turbo_stream do 
                render turbo_stream: turbo_stream.update("search_results",
                        partial: "subs/search_results",
                        locals: {subs: @subs, posts: @posts}
                )
            end
        end
    end

    def create
        @sub = Sub.new(subs_params)
        @sub.moderator_id = current_user.id

        if @sub.save
            flash[:notice] = "Sub Created Successfully 🎒"
            redirect_to sub_url(@sub.id)
        else
            # UserMailer.with(user: current_user,sub: @sub).notify_sub_error.deliver_now
            flash[:error] = "Failed to Create Sub 🔫"
            render :new
        end
    end

    def edit
        @sub = Sub.find_by(:id => params[:id])
        render :edit
    end

    def update
        @sub = Sub.find_by(:id => params[:id])

        if @sub.update(subs_params_update)
            # UserMailer.with(user: current_user,sub: @sub).notify_sub_update.deliver_now
            flash[:notice] = "Sub Updated Successfully 👽🔪"
            redirect_to sub_path(@sub.id)
        else
            # UserMailer.with(user: current_user,sub: @sub).notify_sub_update_error.deliver_now
            flash[:error] = "Failed To Update Sub 🧨"
            render :edit
        end
    end

    private

    def subs_params
        params.require(:subs).permit(:title,:description,:moderator_id)
    end

    def subs_params_update
        params.require(:subs).permit(
            :title,
            :description
        )
    end
    def clarify_user!
        return if current_user.subs.find_by(:id => params[:id])
        render json: 'Forbidden' ,status: :forbidden
    end
end
