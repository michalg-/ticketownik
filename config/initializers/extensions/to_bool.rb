module ToBool
  def to_bool
    ActiveRecord::Type::Boolean.new.cast(self)
  end
  ::Object.send :include, self
end
