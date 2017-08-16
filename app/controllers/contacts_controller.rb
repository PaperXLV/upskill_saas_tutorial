class ContactsController < ApplicationController
   
   # GET request to /contact-us
   # Defined in config/routes.rb
   
   def new
      @contact = Contact.new
   end
   
   # POST request /contacts
   
   def create
      @contact = Contact.new(contact_params)
      if @contact.save
         name = params[:contact][:name]
         email = params[:contact][:email]
         body = params[:contact][:comment]
         ContactMailer.contact_email(name, email, body).deliver
         flash[:success] = "Message Sent, Thank You"
         redirect_to new_contact_path
      else
         flash[:danger] = @contact.errors.full_messages.join(", ")
         redirect_to new_contact_path
      end
   end
   
   # To collect data from form, we need to use
   # strong parameters and whitelist the form fields
   private
      def contact_params
         params.require(:contact).permit(:name, :email, :comment)
      end
end