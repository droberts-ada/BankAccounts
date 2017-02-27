## This class is unfinished

module Bank
  class Owner
    attr_reader :id, :last_name, :first_name, :street_address, :city, :state
    def initialize(id, last_name, first_name, street_address, city, state)
      @id = id
      @last_name = last_name
      @first_name = first_name
      @street_address = street_address
      @city = city
      @state = state
    end

    def self.all

    end

    def self.find

    end


  end #End of class Owner
end # End of module Bank
