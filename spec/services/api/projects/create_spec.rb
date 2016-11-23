describe Api::Projects::Create do

  subject { Api::Projects::Create.new(project, user).process }

  describe '#create project' do
    let(:project) { Project.new(name: 'Example project') }
    let(:user) { create(:user) }

    it { expect{ subject }.to change{ Project.count }.by(1) }
    it { expect{ subject }.to change{ ProjectsUser.count }.by(1) }
  end
end


