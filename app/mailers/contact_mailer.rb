class ContactMailer < ActionMailer::Base
   default to: 'zingerbro@gmail.com'
   def contact_email(name, email, body)
      @name = name
      @email = email
      @body = body
      mail(from: email, subject: 'DevMatch Contact Message')
   end
end