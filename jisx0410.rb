module JISX0410
  ZEROJI = 0
  ICHIJI = 1 
  NIJI = 2
  JYUBAI = 2
  GOBAI = 3 
  NIBAI = 4 
  SANJI = 5 
  NIBUN = 6
  YONBUN = 7
  HACHIBUN = 8
  JYUROKUBUN = 9
  SANJYUNIBUN = 10

  STRAIGHT = [ICHIJI, NIJI, SANJI, 
              NIBUN, YONBUN, HACHIBUN, JYUROKUBUN, SANJYUNIBUN]
  JIS = [ICHIJI, NIJI, SANJI]
  BUNS = [NIBUN, YONBUN, HACHIBUN, JYUROKUBUN, SANJYUNIBUN]
  BAIS = [GOBAI, NIBAI]

  STEPS = {
    ICHIJI => [1, Rational(2, 3)],
    NIJI => [Rational(1, 8), Rational(1, 12)],
    SANJI => [Rational(1, 16), Rational(1, 24)],
    NIBAI => [Rational(1, 40), Rational(1, 60)],
    SANJI => [Rational(1, 80), Rational(1, 120)],
    NIBUN => [Rational(1, 160), Rational(1, 240)],
    YONBUN => [Rational(1, 320), Rational(1, 480)],
    HACHIBUN => [Rational(1, 640), Rational(1, 960)],
    JYUROKUBUN => [Rational(1, 1280), Rational(1, 1920)],
    SANJYUNIBUN => [Rational(1, 2560), Rational(1, 3840)]
  }

  def level_of(code)
    case code.to_s.size
    when 4
      ICHIJI
    when 6
      NIJI
    when 7
      GOBAI
    when 8
      SANJI
    when 9
      code.to_s[8] == '5' ? NIBAI : NIBUN
    when 10
      YONBUN
    when 11
      HACHIBUN
    when 12
      JYUROKUBUN
    when 13
      SANJYUNIBUN
    else
      raise "Could not determine the level for the code #{code}."
    end
  end
  module_function :level_of

  def divs_to_code_component(lat_div, lng_div, level)
    if JIS.include?(level)
      "#{lat_div}#{lng_div}"
    elsif BUNS.include?(level)
      case [lng_div, lat_div]
      when [0, 0]
        1.to_s
      when [1, 0]
        2.to_s
      when [0, 1]
        3.to_s
      when [1, 1]
        4.to_s
      end
    else
      raise "Level #{level} is not supported yet."
    end
  end
  module_function :divs_to_code_component

  def encode(lng, lat, level = SANJI)
    code = ''
    lng -= 100
    STRAIGHT.each {|l|
      lat_div = (lat / STEPS[l][1]).floor
      lat -= lat_div * STEPS[l][1]

      lng_div = (lng / STEPS[l][0]).floor
      lng -= lng_div * STEPS[l][0]

      code += divs_to_code_component(lat_div, lng_div, l)
      return code if l == level
    }
    return coerce_code(code, level)
  end
  module_function :encode

  def coerce_code(code, level)
    raise "coerce_code not yet implemented."
  end
  module_function :coerce_code

  def adjacent(code, d_lng, d_lat)
    raise "not yet implemented."
  end
  module_function :adjacent

  def children(code)
    raise "not yet implemented."
  end
  module_function :children

  def decode_to_bbox(code)
    raise "not yet implemented."
  end
  module_function :decode_to_bbox
  alias :bbox :decode_to_bbox

  def decode_to_point(code)
    raise "not yet implemented."
  end
  module_function :decode_to_point
  alias :sowthwest :decode_to_point
end
