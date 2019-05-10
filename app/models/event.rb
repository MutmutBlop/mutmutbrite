class Event < ApplicationRecord

  has_one_attached :picture

  belongs_to :user #admin, class_name: "User"

  has_many :attendances
  has_many :users, through: :attendances

  validates :user_id, presence: true

  #validates :start_date, presence: true
  #validate :cannot_change_the_past

  #validates :duration, presence: true
  #validate :multiple_of_5

  validates :title, presence: true, length: {in: 5..140}

  validates :description, presence: true, length: {in: 20..1000}

  #validates :price, presence: true, inclusion: 1..1000

  validates :location, presence: true
  validate :has_picture

  # Méthode pour vérifier la startdate de l'event,
  # impossible de créer ou modifier un event passé.
  def cannot_change_the_past
	  if start_date.present? && start_date < Date.today
      errors.add(:start_date, "You can't change the past")
	  end
  end

  # Méthode pour vérifier le format de la durée de l'event,
  # impossible de créer sans que ce soit un multiple de 5.
  def multiple_of_5
    if duration == 0 || duration % 5 != 0
  		errors.add(:duration, "it must be a multiple of 5")
  	end
  end

  # Méthode pour calculer la end_date de l'event.
  # def end_date
  # 	start_date + duration * 60
  # end

  def is_coming?(user)
  	if self.attendances.where(user_id: user.id).count > 0
  		return true
  	else
  		return false
  	end
  end

  def has_picture
  	if self.picture.attached? == false
  		errors.add(:picture, "Avec une photo c'est plus sympa !")
  	end
  end

end
