class PropertiesController < ApplicationController
    before_action :authenticate_property_owner!, only: [:new,  :create]

    def show
        @property = Property.find(params[:id])
        @property_reservation = PropertyReservation.new
    end

    def new
        @property = Property.new
    end

    def create
        @property = Property.new(parametros)
        @property.property_owner = current_property_owner
        if @property.save                 
            redirect_to @property
        else
            render :new
        end
    end

    def edit
        @property = Property.find(params[:id])
    end
    
    def update
        @property = Property.find(params[:id])
        @property.update(parametros)
        if @property.persisted?
            redirect_to @property
        else
            render :edit
        end

    end

    def my_properties
        @properties = current_property_owner.properties
    end

    private
    def parametros
        params.require(:property).permit(:title, :description, 
                        :rooms, :parking_slot, :bathrooms, :pets, :daily_rate, :property_type_id, :property_location_id)
    end
end