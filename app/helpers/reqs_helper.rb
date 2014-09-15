module ReqsHelper

  def email_content(new_req)
    email_string = "Dear Sparks,\n\n"

    email_string += "Here is the current \"Req of the Week\" challenge:\n"
    email_string += "Position: " + new_req.title + "\n"
    email_string += "Department: " + Req.get_department_name(new_req.id) + "\n"
    email_string += "Manager: " + new_req.manager + "\n"

    email_string += "\nYou can access the full job description on the GuideSpark careers page: http://www.guidespark.com/about/careers." 
    email_string += " You can always view the latest Req of the Week by visiting http://" + request.host + url_for(reqs_path) + "." 
    email_string += " Again, the Req of the Week pays an additional 2k on top of the standard employee referral bonus of 2k. That’s 4k in your pocket!\n\n"
    email_string += "Thanks for your help!\n\n"

    email_string += "Ryan"

    return email_string

  end

  def generate_mail
    return mail_to "test@test.com", "Company email", subject: "Req of the Week - " + Req.last.title + " - " + Date.today.to_formatted_s(:rfc822), body: email_content(Req.last), id: "autoEmail"
  end


  def friend_email_content(new_req)

    email_string = "Hey!\n\nThere's a great job opening at GuideSpark that I think you'd be perfect for. It's for a "
    email_string += new_req.title + " in the "
    email_string += Req.get_department_name(new_req.id) + " department, reporting to "
    email_string += new_req.manager + ".\n\n"

    email_string += "You can check out more details on the company's careers page:\n\t\t http://www.guidespark.com/about/careers \n\n"

    email_string += "Let me know if you're interested.\n"

  end

  def generate_friend_mail
    return mail_to "", "<span class='fa fa-envelope-o fa-lg'></span>".html_safe, subject: "Job opening at GuideSpark: " + Req.last.title, body: friend_email_content(Req.last), class: 'btn btn-xs btn-primary'
  end

end
