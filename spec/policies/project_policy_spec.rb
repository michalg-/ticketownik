describe ProjectPolicy do
  subject { ProjectPolicy.new(user, project) }

  context 'for a creator' do
    let!(:user) { create(:user) }
    let!(:project) { create(:project, users: [user]) }

    it { should permit(:index) }
    it { should permit(:show) }
    it { should permit(:create) }
    it { should permit(:new) }
    it { should permit(:update) }
    it { should permit(:edit) }
    it { should permit(:destroy) }
  end

  context 'for other user' do
    let!(:user) { create(:user) }
    let!(:collaborator) { create(:user) }
    let!(:project) { create(:project, users: [collaborator]) }

    it { should permit(:index) }
    it { should_not permit(:show) }
    it { should permit(:create) }
    it { should permit(:new) }
    it { should_not permit(:update) }
    it { should_not permit(:edit) }
    it { should_not permit(:destroy) }
  end
end
