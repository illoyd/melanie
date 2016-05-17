# Inject decoratable into V and E
ArangoDB::OGM::Model.send(:include, Draper::Decoratable)