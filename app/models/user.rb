class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  include Associable

  has_and_belongs_to_many :permissions_groups

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def can?(permission)
    permissions.include?(permission)
  end

  def to_s
    email
  end

  private

  def permissions
    @permissions ||= permissions_groups.pluck(:permissions).flatten
  end
end
