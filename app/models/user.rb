class User < ApplicationRecord 
    has_secure_password 
    validate :password_match

    def password_match 
        check = password.match(/#{password_confirmation}/)
        if check == false
            errors.add(:password, "Passwords do not match")
        end
    end

end
