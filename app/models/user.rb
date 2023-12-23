class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :group_participation_application

  def self.find_for_database_authentication(warden_conditions)
  conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["telephone_number = :value", { value: login }]).first
    else
      where(conditions.to_h).first
    end
  end

  def self.guest
    find_or_create_by!(email: 'sample@com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = "ゲスト"
      user.first_name = "ゲスト"           # 適切な値を指定してください
      user.last_name = "ゲスト"            # 適切な値を指定してください
      user.first_name_kana = "ゲスト"      # 適切な値を指定してください
      user.last_name_kana = "ゲスト"       # 適切な値を指定してください
      user.birth_date = Date.new(2000, 1, 1) # 適切な値を指定してください
    end
  end
end


