require 'rails_helper'

RSpec.describe 'snack show page' do

  it 'shows the name of the snack and the price' do
    owner = Owner.create!(name: "Jimbo")
    machine_1 = Machine.create!(location: "Steamboat", owner_id: owner.id)

    chips = Snack.create!(name: "Doritos", price: 1.0)
    snickers = Snack.create!(name: "Snickers", price: 2.0)


    MachineSnack.create!(machine_id: machine_1.id, snack_id: chips.id)
    MachineSnack.create!(machine_id: machine_1.id, snack_id: snickers.id)


    visit "/snacks/#{chips.id}"

    expect(page).to have_content("Doritos:$1.00")
  end

  it 'shows a list of locations where the snack is carried' do
    owner = Owner.create!(name: "Jimbo")
    machine_1 = Machine.create!(location: "Steamboat", owner_id: owner.id)
    machine_2 = Machine.create!(location: "Denver", owner_id: owner.id)
    machine_3 = Machine.create!(location: "Loveland", owner_id: owner.id)

    chips = Snack.create!(name: "Doritos", price: 1.0)
    snickers = Snack.create!(name: "Snickers", price: 2.0)


    MachineSnack.create!(machine_id: machine_1.id, snack_id: chips.id)
    MachineSnack.create!(machine_id: machine_2.id, snack_id: chips.id)
    MachineSnack.create!(machine_id: machine_3.id, snack_id: snickers.id)

    visit "/snacks/#{chips.id}"

    within "#locations" do
      expect(page).to have_content("Steamboat")
      expect(page).to have_content("Denver")
      expect(page).to_not have_content("Loveland")
    end
  end

  it 'shows the average price for each machine' do
    owner = Owner.create!(name: "Jimbo")
    machine_1 = Machine.create!(location: "Steamboat", owner_id: owner.id)
    machine_2 = Machine.create!(location: "Denver", owner_id: owner.id)
    machine_3 = Machine.create!(location: "Loveland", owner_id: owner.id)

    chips = Snack.create!(name: "Doritos", price: 1.0)
    snickers = Snack.create!(name: "Snickers", price: 2.0)
    hersheys = Snack.create!(name: "Hersheys", price: 3.0)

    MachineSnack.create!(machine_id: machine_1.id, snack_id: chips.id)
    MachineSnack.create!(machine_id: machine_1.id, snack_id: snickers.id)
    MachineSnack.create!(machine_id: machine_2.id, snack_id: chips.id)
    MachineSnack.create!(machine_id: machine_2.id, snack_id: hersheys.id)

    visit "/snacks/#{chips.id}"

    within "#locations-#{machine_1.id}" do
      expect(page).to have_content("Average Price: $1.50")
    end

    within "#locations-#{machine_2.id}" do
      expect(page).to have_content("Average Price: $2.00")
    end
  end

  it 'shows the snack count for each snack in the machine' do
    owner = Owner.create!(name: "Jimbo")
    machine_1 = Machine.create!(location: "Steamboat", owner_id: owner.id)
    machine_2 = Machine.create!(location: "Denver", owner_id: owner.id)

    chips = Snack.create!(name: "Doritos", price: 1.0)
    snickers = Snack.create!(name: "Snickers", price: 2.0)
    hersheys = Snack.create!(name: "Hersheys", price: 3.0)

    MachineSnack.create!(machine_id: machine_1.id, snack_id: chips.id)
    MachineSnack.create!(machine_id: machine_1.id, snack_id: snickers.id)
    MachineSnack.create!(machine_id: machine_2.id, snack_id: chips.id)

    visit "/snacks/#{chips.id}"

    within "#locations-#{machine_1.id}" do
      expect(page).to have_content("Snack Type: 2")
    end

    within "#locations-#{machine_2.id}" do
      expect(page).to have_content("Snack Type: 1")
    end
  end
end
