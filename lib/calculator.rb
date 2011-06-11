module Calculator
  
  BATTING  = 5.59
  X_BORDER = 20
  
  class Backing
    PER_YARD = 6.5
     
     def self.price(dim)
       w = (dim[:width] + 8) / 40
       length = dim[:height] + 8
       
       ((w * length)/36) * PER_YARD 
     end
  end
  
  class Quilting
    FEATHERING       = 10
    CUSTOM           = 20
    PANTAGRAM        = 30
    INTERPRETIVE     = 40
    LG_MEANDERING    = 50
    MED_MEANDERING   = 60
    SM_MEANDERING    = 70
    HEAT_WAVE        = 80
    LEAF_RIBBON      = 90
    HEART_RIBBON     = 100
    HEART            = 110
    LG_DESIGNER      = 120
    FEATHER_MEDLEY   = 130
    
    X_LT_STIPPLING   = 140
    X_SM_STIPPLING   = 150
    
    LABELS = { FEATHERING => 'All Over Feathering', CUSTOM => 'Custom Quilting', PANTAGRAM => 'Pantagram', INTERPRETIVE => 'Interpretive Quilting', LG_MEANDERING => 'Large Meandering',
               MED_MEANDERING => 'Medium Meandering', SM_MEANDERING => 'Small Meandering', HEAT_WAVE => 'Heat Wave Edge to Edge',
               LEAF_RIBBON => 'Leaf & Ribbon design', HEART => 'Heart all over design', HEART_RIBBON => 'Heart & Ribbon all over design', LG_DESIGNER => 'Large all over design',
               FEATHER_MEDLEY => 'Edge to Edge Feather Medley', X_LT_STIPPLING => 'Extra Lite Stippling or Quilting', X_SM_STIPPLING => 'Extra Small Stippling or Quilting' }

    VALUES = { FEATHERING => 0.016, CUSTOM => 0.02, PANTAGRAM => 0.016, INTERPRETIVE => 0.04, LG_MEANDERING => 0.016,
               MED_MEANDERING => 0.02, SM_MEANDERING => 0.04, HEAT_WAVE => 0.02,
               LEAF_RIBBON => 0.016, HEART => 0.016, HEART_RIBBON => 0.016, LG_DESIGNER => 0.016,
               FEATHER_MEDLEY => 0.02, X_LT_STIPPLING => 20, X_SM_STIPPLING => 25 }
               
    STRAIGHT = [X_LT_STIPPLING, X_SM_STIPPLING, X_BORDER]
    
    def self.options_for_select
      LABELS.sort.unshift([nil, "Please Select"]).collect { |arr| arr.reverse }
    end
  end
  
  class Binding
    NONE           = 0
    SEW            = 10
    MACHINE_FRONT  = 20
    MACHINE_BOTH   = 30
    FINISHING      = 40
    
    LABELS = { NONE => 'No Binding Needed', SEW => 'Sew on Binding', MACHINE_FRONT => 'Machine Front/Hand-stitched Back',
               MACHINE_BOTH => 'Machine Sewn', FINISHING => 'Finishing Binding Only' }

    VALUES = { NONE => 0, SEW => 0.04, MACHINE_FRONT => 0.08,
               MACHINE_BOTH => 0.06, FINISHING => 0.08 }
               
    def self.options_for_select
      LABELS.sort.unshift([nil, "Please Select"]).collect { |arr| arr.reverse }
    end
  end
  
  class Threading
    BASE    = 6
    ADD     = 4
    SPECIAL = 10
  end
  
  def self.sq_in(w, h) 
    (w * h).round
  end

  def self.estimate(params)
    sq_inches = self.sq_in(params[:width].to_f, params[:height].to_f)
    batting   = params[:batting] == 'true' ? 0 : (sq_inches / 1296) * BATTING
    quilting  = Quilting::STRAIGHT.include?(params[:quilting].to_i) ?
                  Quilting::VALUES[params[:quilting].to_i] :
                    Quilting::VALUES[params[:quilting].to_i] * sq_inches
    
    (params[:borders].to_i * X_BORDER) + batting + quilting + (Binding::VALUES[params[:binding].to_i] * sq_inches) + (Threading::BASE + (params[:thread].to_i * Threading::ADD)) + Backing.price({:height => params[:height].to_f, :width => params[:width].to_f})
  end
end