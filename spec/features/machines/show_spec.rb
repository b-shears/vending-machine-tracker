require 'rails_helper'

RSpec.describe 'machine show page' do
  it 'shows the name of the snacks & the price' do
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

    expect(page).to have_content("Doritos: $1.00")
    expect(page).to have_content("Snickers: $2.00")
    expect(page).to_not have_content("Spam: $3.00")
  end

  it 'shows the average in price of snacks in a machine' do
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

    expect(page).to have_content("Average Price: $1.50")

  end
end
