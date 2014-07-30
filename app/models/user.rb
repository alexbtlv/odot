class User < ActiveRecord::Base
  has_secure_password

  has_many :todo_lists

  validates :email, presence: true,
                    uniqueness: true,
                    format: {
                      with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
                    }

  before_save :downcase_email

  def downcase_email
    self.email = email.downcase
  end

  def generate_password_reset_token!
    update_attribute(:password_reset_token, SecureRandom.urlsafe_base64(48))
  end

  def create_default_lists
    tutorial = todo_lists.find_or_create_by(title: "Odot tutorial")
    tutorial.todo_items.find_or_create_by(content: "qewrt")
    tutorial.todo_items.find_or_create_by(content: "qewr256t")
    tutorial.todo_items.find_or_create_by(content: "qeqewwrt")
    tutorial.todo_items.find_or_create_by(content: "qewesdcxwrt")
    tutorial.todo_items.find_or_create_by(content: "qet43wrt")
    tutorial.todo_items.find_or_create_by(content: "qeswrt")
    tutorial.todo_items.find_or_create_by(content: "qe65432wrt")
  end
end
