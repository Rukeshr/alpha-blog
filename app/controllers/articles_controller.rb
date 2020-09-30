class ArticlesController < ApplicationController
    before_action :common_article, only: [:show, :edit, :update, :destroy] 
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]
 
    def show    
    end
    
    def index
        @articles = Article.paginate(page: params[:page], per_page: 3)
    end
    def new
        @article = Article.new
    end
    def edit
        
    end
    def create
        @article = Article.new(common_params)
        @article.user = User.first
        if @article.save
            flash[:notice] = "Article was created successfully."
        redirect_to @article
        else
            render 'new'
        end
    end
    def update
        
        if @article.update(common_params)
            flash[:notice] = "Article was updated successfully."  
            redirect_to @article
        else
            render 'edit'
        end
        end

        def destroy
            
            @article.destroy
            redirect_to articles_path

        end
        #DRY tech is using here
        private
        def common_article
            @article = Article.find(params[:id])
        end

        def common_params
            params.require(:article).permit(:title,:description, category_ids: [])
        end

        def require_same_user
            if current_user != @article.user && !current_user.admin?
                flash[:alert] = "You can only edit or delete your own article"
                redirect_to @article
            end
        end



end