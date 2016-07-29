class VersoesController < ApplicationController
  before_action :set_versao, only: [:show, :edit, :update, :destroy]

  # GET /versoes
  # GET /versoes.json
  def index
    @versoes = Versao.all
     @pagen = 1
    


  end

  # GET /versoes/1
  # GET /versoes/1.json
  def show
  end

  # GET /versoes/new
  def new
    @versao = Versao.new
  end

  # GET /versoes/1/edit
  def edit
  end

  # POST /versoes
  # POST /versoes.json
  def create
    @versao = Versao.new(versao_params)

    respond_to do |format|
      if @versao.save
        format.html { redirect_to @versao, notice: 'Versao was successfully created.' }
        format.json { render :show, status: :created, location: @versao }
      else
        format.html { render :new }
        format.json { render json: @versao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /versoes/1
  # PATCH/PUT /versoes/1.json
  def update
    respond_to do |format|
      if @versao.update(versao_params)
        format.html { redirect_to @versao, notice: 'Versao was successfully updated.' }
        format.json { render :show, status: :ok, location: @versao }
      else
        format.html { render :edit }
        format.json { render json: @versao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /versoes/1
  # DELETE /versoes/1.json
  def destroy
    @versao.destroy
    respond_to do |format|
      format.html { redirect_to versoes_url, notice: 'Versao was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_versao
      @versao = Versao.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def versao_params
      params.require(:versao).permit(:numero, :data)
    end
end
