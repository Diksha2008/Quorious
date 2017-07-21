class AnswersController < SetLayoutController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]


  # GET /answers
  # GET /answers.json
  def index
    @questions = Question.all.order('created_at DESC')
    @answer = Answer.new
  end

  # GET /answers/1
  # GET /answers/1.json
  # def show
  # end

  # GET /answers/new
  # def new
  #   @answer = Answer.new
  # end

  # GET /answers/1/edit
  # def edit
  # end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user

    respond_to do |format|
      if @answer.save
        format.html { redirect_to '/', notice: 'Answer was successfully submitted.' }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { redirect_to '/answers', alert: 'You cannot submit blank answer! :(' }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:content, :user_id, :question_id)
    end
end
