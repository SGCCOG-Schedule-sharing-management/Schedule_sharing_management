class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :group_participation_applications
  has_many :schedule_participant, dependent: :destroy
  has_one_attached :profile_image


  def self.find_for_database_authentication(warden_conditions)
  conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["email = :value", { value: login }]).first
    else
      where(conditions.to_h).first
    end
  end

def self.guest
  user = find_or_initialize_by(email: 'sample@com')
  unless user.persisted?
    user.password = SecureRandom.urlsafe_base64
    user.nickname = "ゲスト"
    user.first_name = "-"
    user.last_name = "guest"
    user.first_name_kana = "-"
    user.last_name_kana = "ゲスト"
    user.birth_date = Date.new(2000, 1, 1)

    # 保存可能かどうかを確認
    if user.valid?
      user.save!
    else
      # もし保存不可能ならばエラーログを表示（開発環境でのみ）
      Rails.logger.error(user.errors.full_messages.join(", ")) if Rails.env.development?
    end
  end
  user
end

end


