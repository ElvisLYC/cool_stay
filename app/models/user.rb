class User < ApplicationRecord
  # mount uploader like this?
  include Clearance::User
  mount_uploader :avatar, AvatarUploader
  enum role: [:customer, :host, :moderator, :superadmin]
  has_many :listings
  has_many :authentications, dependent: :destroy
  def self.create_with_auth_and_hash(authentication, auth_hash)
    user = self.create!(
      full_name: auth_hash["info"]["name"],
      email: auth_hash["info"]["email"],
      password: SecureRandom.hex(10)
    )

    user.authentications << authentication
    return user
  end

  # grab google to access google for user data
  def google_token
    x = self.authentications.find_by(provider: 'google_oauth2')
    return x.token unless x.nil?
  end

  # uploader = AvatarUploader.new
  # uploader.store!(my_file)
  # uploader.retrieve_from_store!('my_file.png')
  #
  # u = User.new
  # u.avatar = params[:file] # Assign a file like this, or
  #
  # # like this
  # u.save!
  # u.avatar.url # => '/url/to/file.png'
  # u.avatar.current_path # => 'path/to/file.png'
  # u.avatar_identifier
end
