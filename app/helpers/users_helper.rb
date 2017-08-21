module UsersHelper
    def job_title_icon
        if @user.profile.job_title == "Developer"
            "<i class='fa fa-code'></i>".html_safe
        elsif @user.profile.job_title == "Investor"
            "<i class='fa fa-money'></i>".html_safe
        elsif @user.profile.job_title == "Entrepreneur"
            "<i class='fa fa-lightbulb-o'></i>".html_safe
        end
    end
    
    
    def check_search_to_name(search, first, last)
        if search == nil
            return true
        else
           splitsearch = search.split
           
           validations = []
           splitsearch.each do |cur|
               # START HERE 
               #check if the search matches either the first or last name
               matchfirst = true
               matchlast = true
               #check first name
               iterator = 0
               begin
                   cur.split("").each do |ch|
                      if ch.downcase != first[iterator].downcase
                          matchfirst = false
                      end
                      iterator = iterator + 1
                   end
                   iterator = 0
                   cur.split("").each do |ch|
                       if ch.downcase != last[iterator].downcase
                           matchlast = false
                       end
                       iterator = iterator + 1
                   end
                   (matchfirst || matchlast) ? validations.push(true) : validations.push(false)
                rescue
                    validations.push(false)
                end
           end
           
           validations.each do |valid|
              if !valid
                  return false
              end
           end
           return true
        end
    end
end