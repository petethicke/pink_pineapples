class Movie < ActiveRecord::Base
  scope :search, -> (params) { where("title like ? OR director like ? ", "%#{params}%", "%#{params}%") }
  # binding.
  # scope :search, -> (director) { where("director like ?", director) }
  # scope :search, -> (runtime_in_minutes) { where(runtime_in_minutes => self.runtime_length)}

  has_many :reviews
  mount_uploader :image, ImageUploader

  validates :title,
  presence: true

  validates :director,
  presence: true

  validates :runtime_in_minutes,
  numericality: { only_integer: true }

  validates :description,
  presence: true

  # validates :poster_image_url,
  # presence: true

  validates :release_date,
  presence: true

  # validate :release_date_is_in_the_future

  # def self.search(params)
  #   result = Movie.all

  #   if params[:title].present?
  #     result = result.where("title like ?", params[:title])
  #   end

  #   if params[:director].present?
  #     result = result.where("director like ?", params[:director])
  #   end

  #   if params[:runtime_in_minutes] != '0'
  #     runtime_length = convert_numbers(params[:runtime_in_minutes])
  #     result = result.where(:runtime_in_minutes => runtime_length)
  #   end  
  #   result
  # end

  def review_average
    if !reviews.empty?
      reviews.sum(:rating_out_of_ten)/reviews.size
    end
  end

  def self.convert_numbers(length_key)
    case length_key
    when '1'
      0..90
    when '2'
      90..120
    else
      120..999
    end
  end


  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

end
