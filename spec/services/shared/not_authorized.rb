RSpec.shared_examples "not authorized" do |parameter|
  context 'when the user is not authorized' do
    let(:current_user) { nil }

    it 'return not authorized' do
      expect(result[:errors].first.downcase).to include('not authorized')
    end
  end
end
