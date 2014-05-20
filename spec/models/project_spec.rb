require 'spec_helper'

describe Project do
  describe 'Validations' do
    it 'requires a unique project name (case insensitive)' do
      name = 'CoolestProjectEver'
      Project.create!(:project_name => name, :project_api => SecureRandom.uuid)
      new_project = Project.new(:project_name => name, :project_api => SecureRandom.uuid)
      new_project.valid?
      expect(new_project.errors[:project_name]).to match_array ["has already been taken"]
    end
    it 'requires a unique project api' do
      uuid = SecureRandom.uuid
      Project.create!(:project_name => 'CoolestProjectEver', :project_api => uuid)
      new_project = Project.new(:project_name => 'CoolestProjectEver', :project_api => uuid)
      new_project.valid?
      expect(new_project.errors[:project_api]).to match_array ["has already been taken"]
    end
  end
end
