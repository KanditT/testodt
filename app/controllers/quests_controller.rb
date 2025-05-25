class QuestsController < ApplicationController
  before_action :set_quest, only: %i[ show edit update destroy ]

  # GET /quests or /quests.json
  def index
    @questschecked = Quest.where(status: true)
    @questsunchecked = Quest.where(status: false)
    @quests = Quest.all
    @questnew = Quest.new

    @photo = Photo.first
  end

  # GET /quests/1 or /quests/1.json
  def show
  end

  # GET /quests/new
  def new
    @quest = Quest.new
  end

  # GET /quests/1/edit
  def edit
  end

  # POST /quests or /quests.json
  def create
    @quest = Quest.new(quest_params)
    @quest.status = false

    respond_to do |format|
      if @quest.save
        format.html {
          flash[:notice] = "Quest created successfully"
          redirect_to root_path
        }
        format.json { render :show, status: :created, location: @quest }
      else
        @questschecked = Quest.where(status: true)
        @questsunchecked = Quest.where(status: false)
        @quests = Quest.all
        @questnew = @quest
        @photo = Photo.first

        format.html { render "index", status: :unprocessable_entity }
        format.json { render json: @quest.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @quest.destroy!

    respond_to do |format|
      format.html {
        flash[:notice] = "Quest deleted successfully"
        redirect_to root_path, status: :see_other
      }
      format.json { head :no_content }
    end
  end

  # PATCH/PUT /quests/1 or /quests/1.json
  def update
    Rails.logger.debug "Quest update params: #{params.inspect}"
    Rails.logger.debug "Quest before update: #{@quest.inspect}"

    respond_to do |format|
      if @quest.update(quest_params)
        Rails.logger.debug "Quest after update: #{@quest.inspect}"
        format.html { redirect_to root_path }
        format.json { render json: { status: "success" } }
      else
        Rails.logger.debug "Quest update failed: #{@quest.errors.inspect}"
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quest.errors, status: :unprocessable_entity }
      end
    end
  end


  def next
    # If it's the last photo, it assigns the first one.
    @photo = Photo.find_by("id > ?", params[:id].to_i) || Photo.first

    render @photo # Renders _photo partial
  end

  def previous
    # If it's the first photo, it assigns the last one
    @photo = Photo.order(id: :desc).find_by("id < ?", params[:id].to_i) || Photo.last

    render @photo # Renders _photo partial
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quest
      @quest = Quest.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def quest_params
      params.expect(quest: [ :name, :status ])
      params.require(:quest).permit(:name, :status)
    end
end
