class QuestionsController < InheritedResources::Base
  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]
  has_scope :not_answered

  index! do |format|
    params[:nav] ||= "created_at"
    params[:order] ||= "desc"
  end

  show! do |format|
    @question.increment!(:view_count)
    @answer = @question.answers.build
  end

  protected
    def begin_of_association_chain
      current_user
    end

    def resource
      @question = Question.find(params[:id])
    end

    def collection
      @questions = Question.includes(:user, :tags)
      @questions = @questions.order(params[:order] ? "#{params[:nav]} #{params[:order]}" : "created_at desc")
      @questions = @questions.paginate(:page => params[:page], :per_page => Question.per_page)
    end
end
