class Codabra < ActiveRecord::Base
  attr_accessible :email, :name, :locale, :password, :password_confirmation, :active, :level

  scope :champions, where(active: true).order("level desc")

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :locale, presence: true, inclusion: {in: LocaleDispatcher::LOCALES}

  has_many :battles, foreign_key: :creator_id
  has_many :won_battles, class_name: 'Battle', foreign_key: :winner_id

  has_many :programs, foreign_key: :owner_id

  acts_as_authentic do |c|
    c.login_field = :name
    c.validate_login_field = false
    c.require_password_confirmation = true
  end

  def deliver_password_reset_instructions!
    Notifier.password_reset_instructions(self).deliver
  end

  def email_with_name
    "#{self.name.capitalize} <#{self.email}>"
  end

  def wins_count
    self.won_battles.where(public: true).count
  end

end
