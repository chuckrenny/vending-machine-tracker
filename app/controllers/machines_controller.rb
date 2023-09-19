class MachinesController < ApplicationController
  def index
    @owner = Owner.find(params[:owner_id])
  end

  def show
    @machine = Machine.find(params[:id])
  end

  def add_snack
    machine = Machine.find(params[:id])
    snack = Snack.find(params[:snack_id])
    machine.snacks << snack
  
    redirect_to machine_path(machine)
  end
end
