html {
    head {
        title "Infraportal: $($data.Title)"
        link -rel stylesheet -type text/css -href /styles/app.css
    }
    body {
        header {
            h3 "Infraportal: $($data.Title)"
            h4 { 
                if ($data.pagename -ne 'home') { a -href / { 'Home' } } 
            }
        }
        div -Class content {
            if ($data._Content) {
                $data._Content
            } else { 
                Use-PodePartialView $data.pagename -Data $data
            }
        }
        Use-PodePartialView footer
    }
}
