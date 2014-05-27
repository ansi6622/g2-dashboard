class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new
    @project.project_name = params[:project][:project_name]
    @project.project_api = SecureRandom.uuid
    if @project.save
      redirect_to projects_path
    else
      render new_project_path
    end
  end

  def show
    @project = Project.find(params[:id])
  end

end
