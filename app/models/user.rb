class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  include Associable
  include Tokenable

  has_and_belongs_to_many :permissions_groups

  has_many :devices

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def can?(permission)
    permissions.include?(permission)
  end

  def to_s
    email
  end

  protected

  def permissions
    @permissions ||= permissions_groups.pluck(:permissions).flatten
  end
end
