describe CommentPolicy do
  subject { CommentPolicy.new(user, comment) }

  context 'for a creator' do
    let!(:user) { create(:user) }
    let!(:comment) { create(:comment, author_id: user.id, ticket: create(:ticket)) }

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
    let!(:author) { create(:user) }
    let!(:comment) { create(:comment, author_id: author.id, ticket: create(:ticket)) }

    it { should permit(:index) }
    it { should permit(:show) }
    it { should_not permit(:create) }
    it { should_not permit(:new) }
    it { should_not permit(:update) }
    it { should_not permit(:edit) }
    it { should_not permit(:destroy) }
  end
end
