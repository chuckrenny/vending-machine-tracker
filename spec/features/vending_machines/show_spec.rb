require 'rails_helper'

RSpec.describe 'When a user visits a vending machine show page', type: :feature do
  before :each do
    @owner = Owner.create(name: "Sam's Snacks")
    @dons  = @owner.machines.create(location: "Don's Mixed Drinks")
    @snack_1 = Snack.create!(name: "White Castle Burger", price: 3.5)
    @snack_2 = Snack.create!(name: "Pop Rocks", price: 1.5)
    @snack_3 = Snack.create!(name: "Flaming Hot Cheetos", price: 2.5)
    @snack_4 = Snack.create!(name: "Chocolate Bar", price: 4.0)
    

    @machine_1_snack_1 = @dons.machine_snacks.create!(machine: @dons, snack: @snack_1)
    @machine_1_snack_2 = @dons.machine_snacks.create!(machine: @dons, snack: @snack_2)
    @machine_1_snack_3 = @dons.machine_snacks.create!(machine: @dons, snack: @snack_3)
  end

  scenario 'they see the location of that machine' do
    visit machine_path(@dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end

  # US 1
  it 'displays all snacks and prices associated to the vending machine' do
    visit machine_path(@dons)

    expect(page).to have_content("#{@snack_1.name}: $#{@snack_1.price}")
    expect(page).to have_content("#{@snack_2.name}: $#{@snack_2.price}")
    expect(page).to have_content("#{@snack_3.name}: $#{@snack_3.price}")
  end

  # US 1
  it 'displays average price of all snacks associated to the vending machine' do
    visit machine_path(@dons)

    expect(page).to have_content("Average Price: $#{@dons.average_snack_price}")
  end

  # US 2
  it 'displays a form to add an existing snack to that vending machine' do
    visit machine_path(@dons)

    fill_in 'Snack ID', with: @snack_4.id
    click_on 'Submit'

    expect(current_path).to eq(machine_path(@dons))
    expect(page).to have_content("#{@snack_4.name}: $#{@snack_4.price}")
  end
end
