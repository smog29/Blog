require 'rails_helper'

RSpec.describe Authentication::SignInService, type: :service do
  let(:user) { create(:user, email: 'test@example.com', password: 'Password123!') }

  describe '.call' do
    it 'returns a token when the email and password are correct' do
      result = Authentication::SignInService.call(email: user.email, password: 'Password123!')

      expect(result[:token]).not_to be_nil
      expect(result[:errors]).to be_empty

      decoded_token = JWT.decode(result[:token], ENV["JWT_SECRET"], true, algorithm: 'HS256')
      expect(decoded_token.first['user_id']).to eq(user.id)
    end
  end
end
