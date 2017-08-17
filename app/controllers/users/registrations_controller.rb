class Users::RegistrationsController < Devise::RegistrationsController
   
   before_action :select_plan, only: :new
   
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