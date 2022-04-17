module ApplicationHelper
    def br_date(us_date)
        us_date.strftime("%d/%m/%Y")
    end

    def locale
        if I18n.locale == :en
            "Estados Unidos"
        else
            "Portugues Brasil"
        end
    end
end
