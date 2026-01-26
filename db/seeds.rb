# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Add your questions here
questions = [
  "What is the meaning of life?",
  "What makes you happy?",
  "What would you do if you had no fear?",
  "What is your biggest regret?",
  "What are you most grateful for?",
  "What is your definition of success?",
  "What would you tell your younger self?",
  "What is the best advice you've ever received?",
  "What do you want to be remembered for?",
  "What is something you've always wanted to learn?"
]

questions.each do |content|
  Question.find_or_create_by!(content: content) do |q|
    q.used = false
    q.today = false
  end
end
