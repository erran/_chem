class Symbol
  def to_element
    Chem::Element.find(self)
  end
end
