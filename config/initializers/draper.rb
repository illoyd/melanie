# Inject decoratable into V and E
ArangoDB::OGM::Document.send(:include, Draper::Decoratable)