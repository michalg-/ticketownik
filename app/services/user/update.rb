class User::Update < Struct.new(:user_params)

  def process
    user.transaction do
      user.assign_attributes(user_params.except(:photo))
      process_photo
      user.save!
    end
  end

  private
  def process_photo
    user.photo.destroy! and return if user_params[:remove_photo].to_bool

    if user.photo
      user.photo.update!(asset: user_params[:photo])
    else
      user.create_photo!(asset: user_params[:photo])
    end
  end

  def user
    @user ||= User.find(user_params[:id])
  end
end
