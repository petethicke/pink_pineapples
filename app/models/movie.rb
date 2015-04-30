class Movie < ActiveRecord::Base

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

  def self.search(params)
    result = Movie.all

    if params[:title].present?
      result = result.where("title like ?", params[:title])
    end

    if params[:director].present?
      result = result.where("director like ?", params[:director])
    end

    # if params[:runtime].present?
    #   #
    # end

    result

    # if params != nil
    #   Movie.where("params like ?", "%#{params}%")
    # else
    #   Movie.all
    # end
  end

  def review_average
    if !reviews.empty?
      reviews.sum(:rating_out_of_ten)/reviews.size
    end
  end

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

end
