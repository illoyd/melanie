##
# Abstract job class for auto-magically converting a RID reference to an object, then performing something with said object.
class WithObjectJob < ApplicationJob

  def perform(id, *params)
    id = id.id if id.respond_to?(:id)
    obj = Orientdb::ORM::Type.lookup(:link).cast(id).fetch
    perform_with_object(obj, *params)
  end

  def perform_with_object(obj, *params)
    raise NotImplemented
  end

end # WithObjectJob
