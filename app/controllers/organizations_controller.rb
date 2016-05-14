class OrganizationsController < VerticesController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  decorates_assigned :organization

  # GET /organizations
  # GET /organizations.json
  def index
    @vertices = @organizations = Organization.all.to_a
    respond_with @organizations
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    respond_with @organization
  end

  # GET /organizations/new
  def new
    @vertex = @organization = Organization.new
    respond_with @organization
  end

  # GET /organizations/1/edit
  def edit
    respond_with @organization
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @vertex = @organization = Organization.new(organization_params)
    @organization.save
    respond_with @organization
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    @organization.update(organization_params)
    respond_with @organization
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_with @organization
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @vertex = @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name)
    end
end
