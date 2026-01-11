class HomeController < ApplicationController
    def index
        @properties = Property.all
        @property_type = PropertyType.all
        @property_location = PropertyLocation.all
    end
end