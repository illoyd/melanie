class NotesController < ApplicationController
  before_action :set_notable, only: [:create]
  before_action :set_notes, only: [:index]
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  # GET /notes.json
  def index
    respond_with @notes
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    respond_with @note
  end

  # GET /notes/new
  def new
    @note = Note.new
    respond_with @note
  end

  # GET /notes/1/edit
  def edit
    respond_with @note
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params).tap do |note|
      note.created_by = current_user
      note.updated_by = current_user
    end

    if @note.save! && @notable.present?
      Describe.new(to: @notable, from: @note).save!
    end

    AddMentionsForContentJob.perform_later(@note)
    respond_with @notable
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    @note.update(note_params)
    AddMentionsForContentJob.perform_later(@note.id.to_s)
    # TODO: Fix this update query!
    respond_with @note.out_Describe.first.fetch.target
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    describes = @note.describes.first
    @note.destroy
    respond_with describes
  end

  private
    def set_notes
      @notes = Note.all
    end

    def set_note
      @note = Note.find!(params[:id])
    end

    def set_notable
      @notable = if params[:person_id].present?
        Person.find(params[:person_id])
      elsif params[:organization_id].present?
        Organization.find(params[:organization_id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:body)
    end
end
