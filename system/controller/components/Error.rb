class Error 
  def initialize (code = "unknown", props = [])
    @code = code 
    @props = props
  end

  def code
    return @code
  end

  def prop(id)
    return @props[id] ? @props[id]: ""
  end
end
