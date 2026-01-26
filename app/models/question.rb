class Question < ApplicationRecord
  validates :content, presence: true
  validates :used, inclusion: { in: [true, false] }
  validates :today, inclusion: { in: [true, false] }

  # Returns today's question, cached for 24 hours
  # Uses UTC date so everyone gets the same question at the same time globally
  def self.today_cached
    utc_date = Time.current.utc.to_date
    Rails.cache.fetch("today_question_#{utc_date}", expires_in: 24.hours) do
      find_by(today: true)
    end
  end

  # Selects the next question for today
  # Priority: 1) Questions scheduled for today, 2) Oldest unused question
  def self.select_today_question!
    utc_date = Time.current.utc.to_date
    
    # First, unmark current question
    where(today: true).update_all(today: false)
    
    # Try to find a question scheduled for today
    question = where(scheduled_for: utc_date, used: false).first
    
    # If no scheduled question, pick oldest unused
    question ||= where(used: false).order(:created_at).first
    
    # If all questions are used, reset and start over
    if question.nil?
      update_all(used: false)
      question = order(:created_at).first
    end
    
    if question
      question.update!(today: true, used: true)
      # Clear cache so next request gets fresh question
      Rails.cache.delete("today_question_#{utc_date}")
    end
    
    question
  end
end
