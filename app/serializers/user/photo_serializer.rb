class User::PhotoSerializer < ActiveModel::Serializer
  attributes :assets

  def assets
    {}.tap do |hash|
      object.asset.keys.each do |key|
        hash[key] = object.asset[key].try(:url)
      end
    end
  end

end
