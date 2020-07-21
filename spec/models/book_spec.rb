require 'rails_helper'

RSpec.describe Book, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe 'test description' do

    let(:building) { build_stubbed(:building) }

    it 'test it' do
      building = FactoryBot.build_stubbed(:building)
    end

  end
end