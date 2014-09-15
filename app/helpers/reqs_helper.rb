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

end
