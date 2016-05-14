require 'orientdb/orm'

##
# Cashtag class!
class Cashtag < Orientdb::ORM::V

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
