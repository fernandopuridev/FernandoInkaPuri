class PropertyLocationsController < ApplicationController
    def new
        @property_location = PropertyLocation.new
    end

    def create
        @property_location = PropertyLocation.new(params.require(:property_location).permit(:name))
        if @property_location.save
            redirect_to root_path
        else
            render :new
        end
    end

    def show
        @location = Property.where("property_location_id = ?", params[:id])
    end

end