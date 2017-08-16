class ContactMailer < ActionMailer::Base
   default to: 'zingerbro@gmail.com'
   # these functions use a html.erb file in views/CLASS_NAME and these variables are used in the html file
   def contact_email(name, email, body)
      @name = name
      @email = email
      @body = body
      mail(from: email, subject: 'DevMatch Contact Message')
   end
end