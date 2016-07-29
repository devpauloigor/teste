class AuditasController < ApplicationController
  before_action :set_audita, only: [:show, :edit, :update, :destroy]
 before_filter :authenticate_user!
  # GET /auditas
  # GET /auditas.json
  def index
    @auditas = Audita.all
  end

  # GET /auditas/1
  # GET /auditas/1.json
  def show
  end

  # GET /auditas/new
  def new
    @audita = Audita.new
  end

  # GET /auditas/1/edit
  def edit
  end

  # POST /auditas
  # POST /auditas.json
  def create
    @audita = Audita.new(audita_params)

    respond_to do |format|
      if @audita.save
        format.html { redirect_to @audita, notice: 'Audita was successfully created.' }
        format.json { render :show, status: :created, location: @audita }
      else
        format.html { render :new }
        format.json { render json: @audita.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /auditas/1
  # PATCH/PUT /auditas/1.json
  def update
    respond_to do |format|
      if @audita.update(audita_params)
        format.html { redirect_to @audita, notice: 'Audita was successfully updated.' }
        format.json { render :show, status: :ok, location: @audita }
      else
        format.html { render :edit }
        format.json { render json: @audita.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auditas/1
  # DELETE /auditas/1.json
  def destroy
    @audita.destroy
    respond_to do |format|
      format.html { redirect_to auditas_url, notice: 'Audita was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_audita
      @audita = Audita.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def audita_params
      params.require(:audita).permit(:user_id, :questao_id)
    end
end
