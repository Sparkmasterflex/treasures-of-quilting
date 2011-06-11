module AppSystem
  NAME = "Treasures of Quilting"
  APP_NAME = Rails.application.class.to_s.split("::").first
  
  class Templates
    HOME           = 10
    INFORMATIONAL  = 20
    SALES          = 30
    STORE          = 35
    CONTACT        = 40
    CALCULATOR     = 50
    CALC_DESC      = 60

    LABELS = {HOME => 'Home', INFORMATIONAL => 'Informational', SALES => 'Sales', STORE => 'Store', CONTACT => 'Contact', CALCULATOR => 'Calculator', CALC_DESC => 'Calculator_Desc'}

    def self.options_for_select
      LABELS.sort.unshift([nil, "Please Select"]).collect { |arr| arr.reverse }
    end
  end
end
