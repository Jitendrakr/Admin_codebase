class Event < ActiveRecord::Base
	validates :name, :description, :link,presence: true
	has_many :event_images, :dependent => :destroy
	has_many :image_events, :dependent => :destroy
  #accepts_nested_attributes_for :event_images, :reject_if => proc { |attributes| attributes['property_id'].blank? }
  accepts_nested_attributes_for :event_images,
  :allow_destroy => true,
  :reject_if => proc {|attrs| attrs['pic'].blank? }

  def self.search(search)
  	if search
  		where(' name LIKE ?',"%#{search}%")
  	end
  end

  def self.search2(search)
  	if search
  		where(' event_type LIKE ?',"%#{search}%")
  	end
  end

end
