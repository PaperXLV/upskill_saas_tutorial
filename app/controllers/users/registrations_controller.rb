class Users::RegistrationsController < Devise::RegistrationsController
   # Extend default Devise gem behavior so that
   # users signing up with Pro / Cena account (ID 2 and 3)
   # save with special Stripe subscription funtion.
   # Otherwise Devise signs up user as usual.
   before_action :select_plan, only: :new
   # Called at the end of users.js, the script that hijacks our form submission. Normally would be called right on the submit button, but we need additional information/validation
   def create
      super do |resource|
         if params[:plan]
            resource.plan_id = params[:plan]
            if resource.plan_id == 2
               resource.save_with_subscription
            elsif resource.plan_id == 3
               resource.save_with_subscription
            else
               resource.save
            end
         end
      end
   end
   
   private
      def select_plan
         unless (params[:plan] == '1' || params[:plan] == '2' || params[:plan] == '3')
            flash[:notice] = "Please select a valid plan"
            redirect_to root_url
         end
      end
end