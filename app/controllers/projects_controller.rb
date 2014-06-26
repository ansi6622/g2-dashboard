class ProjectsController < ApplicationController

  before_action :validate_logged_in

  def index
    @memberships = Membership.where(user_id: current_user.id)
    @projects = Project.where(id: @memberships.map(&:project_id))
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new
    @project.project_name = params[:project][:project_name]
    @project.project_api = SecureRandom.uuid
    if @project.save
      Membership.create!(user_id: session[:user_id], project_id: @project.id)
      redirect_to project_path(@project)
    else
      render new_project_path
    end
  end

  def show
    @project = Project.find(params[:id])
    validate_membership(current_user, @project)
    @membership = Membership.new
    applicable_memberships = @project.memberships
    @members = applicable_memberships.map do |membership|
      User.find(membership.user_id)
    end
    @users = User.all - @members

  end

  def documentation
    @project = Project.find(params[:id])
    validate_membership(current_user, @project)
    if request.host.include?('localhost')
      @current_host = "http://#{request.host}:#{request.port}"
    else
      @current_host = "https://#{request.host}"
    end
    @project_api_key = @project.project_api
    @current_time = Time.now.to_i
  end

  private

  def member_of?(user, project)
    Membership.where(:project_id => project.id, :user_id => user.id).count > 0
  end

  def validate_membership(user, project)
    redirect_to root_path, locals: flash[:error] = "You can only view projects you are a member of" if !member_of?(user, project)
  end
end
