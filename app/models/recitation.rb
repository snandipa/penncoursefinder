class Recitation < ActiveRecord::Base
  attr_accessible :listing, :course_id
  
  belongs_to :course
  has_many :meetings, :dependent => :destroy
  
  validates_presence_of :listing, :course_id
  validates_uniqueness_of :listing, :scope => :course_id #ie only one 001 for ESE 451
  

  def listing_to_s
    case
      when listing < 10 then return "00#{listing}"
      when listing < 100 then return "0#{listing}"
      else return "#{listing}"
    end
  end

end
