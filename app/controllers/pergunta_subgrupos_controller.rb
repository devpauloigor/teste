class PerguntaSubgruposController < ApplicationController
  before_action :set_pergunta_subgrupo, only: [:show, :edit, :update, :destroy]
 before_filter :authenticate_user!
  # GET /pergunta_subgrupos
  # GET /pergunta_subgrupos.json
  def index
    @pergunta_subgrupos = QuestaoSubgrupo.all
  end

  # GET /pergunta_subgrupos/1
  # GET /pergunta_subgrupos/1.json
  def show
  end

  # GET /pergunta_subgrupos/new
  def new
    @pergunta_subgrupo = PerguntaSubgrupo.new
  end

  # GET /pergunta_subgrupos/1/edit
  def edit
  end

  # POST /pergunta_subgrupos
  # POST /pergunta_subgrupos.json
  def create
    @pergunta_subgrupo = PerguntaSubgrupo.new(pergunta_subgrupo_params)

    respond_to do |format|
      if @pergunta_subgrupo.save
        format.html { redirect_to @pergunta_subgrupo, notice: 'Pergunta subgrupo was successfully created.' }
        format.json { render :show, status: :created, location: @pergunta_subgrupo }
      else
        format.html { render :new }
        format.json { render json: @pergunta_subgrupo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pergunta_subgrupos/1
  # PATCH/PUT /pergunta_subgrupos/1.json
  def update
    respond_to do |format|
      if @pergunta_subgrupo.update(pergunta_subgrupo_params)
        format.html { redirect_to @pergunta_subgrupo, notice: 'Pergunta subgrupo was successfully updated.' }
        format.json { render :show, status: :ok, location: @pergunta_subgrupo }
      else
        format.html { render :edit }
        format.json { render json: @pergunta_subgrupo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pergunta_subgrupos/1
  # DELETE /pergunta_subgrupos/1.json
  def destroy
    @pergunta_subgrupo.destroy
    respond_to do |format|
      format.html { redirect_to pergunta_subgrupos_url, notice: 'Pergunta subgrupo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pergunta_subgrupo
      @pergunta_subgrupo = PerguntaSubgrupo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pergunta_subgrupo_params
      params.require(:pergunta_subgrupo).permit(:pergunta_id, :sub_grupo_id)
    end
end
