class AuditoriasController < ApplicationController
  before_action :set_auditoria, only: [:show, :edit, :update, :destroy]
 before_filter :authenticate_user!
  # GET /auditorias
  # GET /auditorias.json
  def index
    @auditorias = Auditoria.all
  end

  # GET /auditorias/1
  # GET /auditorias/1.json
  def show
  end

  # GET /auditorias/new
  def new
    @auditoria = Auditoria.new
  end

  # GET /auditorias/1/edit
  def edit
  end

  # POST /auditorias
  # POST /auditorias.json
  def create
    @auditoria = Auditoria.new(auditoria_params)

    respond_to do |format|
      if @auditoria.save
        format.html { redirect_to @auditoria, notice: 'Auditoria was successfully created.' }
        format.json { render :show, status: :created, location: @auditoria }
      else
        format.html { render :new }
        format.json { render json: @auditoria.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /auditorias/1
  # PATCH/PUT /auditorias/1.json
  def update
    respond_to do |format|
      if @auditoria.update(auditoria_params)
        format.html { redirect_to @auditoria, notice: 'Auditoria was successfully updated.' }
        format.json { render :show, status: :ok, location: @auditoria }
      else
        format.html { render :edit }
        format.json { render json: @auditoria.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auditorias/1
  # DELETE /auditorias/1.json
  def destroy
    @auditoria.destroy
    respond_to do |format|
      format.html { redirect_to auditorias_url, notice: 'Auditoria was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auditoria
      @auditoria = Auditoria.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def auditoria_params
      params.require(:auditoria).permit(:user_id, :questao_id)
    end
end
