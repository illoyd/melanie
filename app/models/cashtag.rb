##
# Cashtag class!
class Cashtag
  include ArangoDB::OGM::Vertex

  attribute :text, :string, validates: { presence: true }

end

##
# NyseCashtag class!
class NYSECashtag < Cashtag
end

##
# LseCashtag class!
class LSECashtag < Cashtag
end
