class PeopleController < VerticesController
  before_action :set_people, only: [:index]
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  decorates_assigned :person

  # GET /people
  # GET /people.json
  def index
    respond_with @people
  end

  # GET /people/1
  # GET /people/1.json
  def show
    respond_with @person
  end

  # GET /people/new
  def new
    @vertex = @person = Person.new
    respond_with @person
  end

  # GET /people/1/edit
  def edit
    respond_with @person
  end

  # POST /people
  # POST /people.json
  def create
    @vertex = @person = Person.create(person_params)
    respond_with @person
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    @person.update(person_params)
    respond_with @person
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_with @person
  end

  private
    def set_people
      @vertices = @people = Person.all.to_a
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @vertex = @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(
        :full_name, :phonetic_full_name,
        :preferred_name, :phonetic_preferred_name,
        :formal_greeting, :phonetic_formal_greeting,
        :date_of_birth, :anniversary
      )
    end
end
