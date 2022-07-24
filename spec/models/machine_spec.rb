require 'rails_helper'

RSpec.describe Machine, type: :model do
  describe 'validations' do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
  end

  describe 'relationships' do
    it {should have_many :machine_snacks}
    it {should have_many(:snacks).through(:machine_snacks)}
  end

  describe 'model methods' do
    it 'should calculate average price of the snacks in the machine' do
      owner = Owner.create!(name: "Jimbo")
      machine_1 = Machine.create!(location: "Steamboat", owner_id: owner.id)
      machine_2 = Machine.create!(location: "Denver", owner_id: owner.id)
      chips = Snack.create!(name: "Doritos", price: 1.0)
      snickers = Snack.create!(name: "Snickers", price: 2.0)
      spam = Snack.create!(name: "Spam", price: 3.0)

      MachineSnack.create!(machine_id: machine_1.id, snack_id: chips.id)
      MachineSnack.create!(machine_id: machine_1.id, snack_id: snickers.id)
      MachineSnack.create!(machine_id: machine_2.id, snack_id: spam.id)

      visit "/machines/#{machine_1.id}"
      expect(machine_1.average_price).to eq(1.5)
    end
  end
end
