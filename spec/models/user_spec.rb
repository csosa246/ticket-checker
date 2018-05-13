require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { described_class.new }

  describe "on create" do
    subject { -> { user.run_callbacks(:create) } }
    it { should change(user, :authentication_token).to be }
  end
end
