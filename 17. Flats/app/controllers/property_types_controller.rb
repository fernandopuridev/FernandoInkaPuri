class PropertyTypesController < ApplicationController
    def new 
        @property_type = PropertyType.new()
    end

    def create
        @property_type = PropertyType.new(params.require(:property_type).permit(:name))
        if @property_type.save 
            redirect_to root_path
        else
            render :new
        end
    end

    def show
        @tipo = PropertyType.find(params[:id])
        @type = Property.where("property_type_id = :id", { id: params[:id]})
    end

end