library("shiny")
library("RODBC")
library("DT")
library("RODBCext")
library("shinythemes")


con <- odbcDriverConnect('driver={SQL Server};server=RASIKA-PC;database=HI;trusted_connection=true')
query <- paste0("select * from Login")
aa <<- sqlQuery(con, query)
aa <<- as.data.frame(aa)
bb <<- 0

#query <- paste0("select * from Subscriber")
#a <- sqlQuery(con, query)
#a

ui1 <- function(){
  tagList(tags$h1("Welcome to PATS DB website", align = "center"),theme = shinytheme("flatly"),
          tags$h2("Login Page", align = "center", offset = 50),
          div(id = "login",
              wellPanel(textInput("userName", "Username"),
                        passwordInput("passwd", "Password"),
                        br(), actionButton("Login", "Log in", icon = icon("power-off")))),
          tags$style(type="text/css", "#login {font-size:15px;   text-align: left;position:absolute;
                     top: 40%;left: 52%;margin-top: -100px;margin-left: -150px;}")
          )}

ui2 <- function(){navbarPage(theme = shinytheme("flatly")
                             ,title = "Editor"
                             ,tabPanel("Subscriber"
                                       ,sidebarLayout(
                                         # Side bar Panel
                                         #sidebarPanel(h4("Enter Your Information")
                                         
                                         #)
                                         # Main Panel
                                         sidebarPanel = NULL
                                         ,mainPanel =  mainPanel(h3("Edit Subscriber Info", align = "left")
                                                                 ,column(5, align="left", offset = 0
                                                                         
                                                                         #,textInput("age","Group Sponsored?","")
                                                                         #Group Sponsored
                                                                         ,radioButtons("group","Group Sponsored",list("Y","N"),"", inline = T)
                                                                         #Date of purchase
                                                                         ,dateInput("date", "Date of Purchase", value = NULL, min = NULL, max = NULL,
                                                                                    format = "yyyy-mm-dd", startview = "month", weekstart = 0,
                                                                                    language = "en", width = NULL)
                                                                         #SSN
                                                                         ,numericInput("ssn", "Enter SSN", value = NULL, min = 0, max = NA, step = NA
                                                                         )#,width = '400px')
                                                                         # Insert button
                                                                         ,actionButton("addButton", "Insert", icon = icon("plus"))
                                                                         ,p("Hit Submit")
                                                                         #Update Information
                                                                         ,numericInput("r_sub_id","Enter Subscriber ID to be updated"
                                                                                       , value = NULL, min = 0, max = NA, step = NA)
                                                                         # , value = NULL, min = NA, max = NA, step = NA)
                                                                         #Update Button
                                                                         ,actionButton("uButton", "Update", icon = icon("thumbs-o-up"))
                                                                         ,p("Hit Update")
                                                                         # Delete Information 
                                                                         ,numericInput("Sub_ID","Enter subscriber ID to be deleted"
                                                                                       , value = NULL, min = 0, max = NA, step = NA)
                                                                         # , value = NULL, min = NA, max = NA, step = NA)
                                                                         #Delete Button
                                                                         ,actionButton(inputId = "delete.button", label = "Delete"
                                                                                       , icon = icon("minus"))
                                                                         ,p("To Delete")
                                                                 )
                                                                 
                                         )
                                       )
                             )
                             ,tabPanel("Member"
                                       ,sidebarLayout(
                                         
                                         sidebarPanel = NULL
                                         # Main Panel
                                         ,mainPanel =  mainPanel(h3("Edit Member Info", align = "left")
                                                                 ,column(5, align="left", offset = 0
                                                                         
                                                                         #Maritial Status
                                                                         ,textInput("mar_status","Marital Status","")
                                                                         #Primary Holder
                                                                         ,radioButtons("prime","Primary Holder",list("Y","N"),"", inline = T)
                                                                         #Veteran Status
                                                                         ,textInput("vet_status","Veteran_Status","")
                                                                         #Race
                                                                         ,textInput("race","Race","")
                                                                         #Ethnicity
                                                                         ,textInput("Ethnicity","Ethnicity","")
                                                                         #Occupation
                                                                         ,textInput("Occupation","Occupation","")
                                                                         #Emergency_Contact_Name
                                                                         ,textInput("Ename","Emergency Contact Name","")
                                                                         #Emergency_Contact_Phone_Number
                                                                         ,numericInput("Ephone","Emergency Contact Phone Number"
                                                                                       , value = NULL, min = 0, max = NA, step = NA)
                                                                         #Emergency_Contact_Address_Line1
                                                                         ,textInput("Eaddress","Emergency_Contact_Address_Line1","")
                                                                         #Emergency_Contact_City
                                                                         ,textInput("Ecity","Emergency_Contact_City","")
                                                                         #Emergency_Contact_State
                                                                         ,textInput("Estate","Emergency_Contact_State","")
                                                                         #Emergency_Contact_Zip
                                                                         ,textInput("Ezip","Emergency_Contact_Zip","")
                                                                         #Emergency_Contact_Relationship
                                                                         ,textInput("Erelation","Emergency_Contact_Relationship","")
                                                                         #Sub_Parent
                                                                         ,radioButtons("Sub_Parent","Subscriber Parent",list("Y","N"),"", inline = T)
                                                                         #Sub_Guardian
                                                                         ,radioButtons("Sub_Guardian","Subscriber Guardian",list("Y","N"),"", inline = T)
                                                                         #Subscriber ID
                                                                         ,numericInput("Sub_ID_mem", "Enter Subscriber ID"
                                                                                       , value = NULL, min = 0, max = NA, step = NA
                                                                         )#,width = '400px')
                                                                         # Insert button
                                                                         ,actionButton("mem_addButton", "Insert",icon = icon("plus"))
                                                                         ,p("Hit Submit")
                                                                         #Update Information
                                                                         ,numericInput("r_mem_id","Enter Member ID to be updated"
                                                                                       , value = NULL, min = 0, max = NA, step = NA)
                                                                         #Update Button
                                                                         ,actionButton("mem_uButton", "Update", icon = icon("thumbs-o-up"))
                                                                         ,p("Hit Update")
                                                                         # Delete Information 
                                                                         ,numericInput("mem_ID","Insert Member ID to be deleted"
                                                                                       , value = NULL, min = 0, max = NA, step = NA)
                                                                         #Delete Button
                                                                         ,actionButton(inputId = "mem_delete.button", label = "Delete"
                                                                                       , icon = icon("minus"))
                                                                         ,p("To Delete")
                                                                 )
                                                                 
                                         )
                                       )
                             )
)
}

ui3 <- function(){navbarPage(title = "Viewer",theme = shinytheme("flatly")
                             ,tabPanel("Subscriber"
                                       ,textInput("sub_table","Group Sponsored:Enter your Y or N","")
                                       ,tableOutput("sub_summary")
                             )
                             ,tabPanel("Member"
                                       ,numericInput("mem_table","Enter Member ID"
                                                  , value = NULL, min = 0, max = NA, step = NA)
                                       ,tableOutput("mem_summary")
                             )
)
}

ui = (htmlOutput("page"))
server = (function(input, output,session) {
  
  con <- odbcDriverConnect('driver={SQL Server};server=RASIKA-PC;database=HI;trusted_connection=true')
  
  user <- reactiveValues(Logged = FALSE)
  
  observe({ 
    if (user$Logged == FALSE) {
      if (!is.null(input$Login)) {
        if (input$Login > 0) {
          Username <- isolate(input$userName)
          Password <- isolate(input$passwd)
          
          Id.username <- which(aa$Username == Username)
          Id.password <- which(aa$Password == Password)
          
          cc <<- aa[Id.password,]
          
          if (length(Id.username) > 0 & length(Id.password) > 0) {
            if (Id.username == Id.password) {
              user$Logged <- TRUE
              if(cc$Job_Type == "Entry"){bb <<- 1}else{bb<<-2}
            } else {
              output$text2 <- renderText({
                "Incorrect username or password"
              })
              stop("Incorrect username or password")
            } 
          }
        } 
      }
    }    
  })
  observe({
    if (user$Logged == FALSE) {
      
      output$page <- renderUI({
        div(class="outer",do.call(bootstrapPage,c("",ui1())))
      })
    }
    if (user$Logged == TRUE & bb == 1) 
    {
      output$page <- renderUI({
        div(class="outer",do.call(navbarPage,c(title = "Pats DB Health Insurance Data Entry Page",ui2())))
      })
      print(ui)
    }
    if (user$Logged == TRUE & bb == 2) 
    {
      output$page <- renderUI({
        div(class="outer",do.call(navbarPage,c(title = "Pats DB Health Insurance Data Viewing Page",ui3())))
      })
      print(ui)
    }
  })
  
  insert<-  function(date,group,ssn)
  {
    con <- odbcDriverConnect('driver={SQL Server};server=RASIKA-PC;database=HI;trusted_connection=true')
    
    query <- "insert into Subscriber(Group_Sponsored,Issued_date,SSN) values (?,?,?);"
    
    sqlExecute(con, query
               ,data = list(input$group,input$date,input$ssn)
               ,fetch = TRUE
               ,stringsAsFactors = FALSE)
    
    
  }
  
  insert_mem <-  function(Marital_Status,Primary_Holder,Veteran_Status,Race,Ethnicity,Occupation
                          ,Emergency_Contact_Name,Emergency_Contact_Phone_Number,Emergency_Contact_Address_Line1
                          ,Emergency_Contact_City,Emergency_Contact_State,Emergency_Contact_Zip
                          ,Emergency_Contact_Relationship,Sub_Parent,Sub_Guardian,Subscriber_ID)
  {
    con <- odbcDriverConnect('driver={SQL Server};server=RASIKA-PC;database=HI;trusted_connection=true')
    
    query <- "insert into Member(Marital_Status,Primary_Holder,Race,Veteran_Status,Ethnicity,Occupation
    ,Emergency_Contact_Name,Emergency_Contact_Phone_Number,Emergency_Contact_Address_Line1
    ,Emergency_Contact_City,Emergency_Contact_State,Emergency_Contact_Zip,Emergency_Contact_Relationship
    ,Sub_Parent,Sub_Guardian,Subscriber_ID) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);"
    
    sqlExecute(con, query
               ,data = list(input$mar_status
                            ,input$prime
                            ,input$vet_status
                            ,input$race
                            ,input$Ethnicity
                            ,input$Occupation
                            ,input$Ename
                            ,input$Ephone
                            ,input$Eaddress
                            ,input$Ecity
                            ,input$Estate
                            ,input$Ezip
                            ,input$Erelation
                            ,input$Sub_Parent
                            ,input$Sub_Guardian
                            ,input$Sub_ID_mem)
               ,fetch = TRUE
               ,stringsAsFactors = FALSE)
    
    
  }
  
  delete <-  function(delete)
  {
    con <- odbcDriverConnect('driver={SQL Server};server=RASIKA-PC;database=HI;trusted_connection=true')
    
    query <- "DELETE FROM Subscriber WHERE Subscriber_ID = ?;"
    
    sqlExecute(con, query
               ,data = list(input$Sub_ID)
               ,fetch = TRUE
               ,stringsAsFactors = FALSE)
    
    
  }
  
  delete_mem <-  function(delete)
  {
    con <- odbcDriverConnect('driver={SQL Server};server=RASIKA-PC;database=HI;trusted_connection=true')
    
    query <- "DELETE FROM Member WHERE Member_ID = ?;"
    
    sqlExecute(con, query
               ,data = list(input$mem_ID)
               ,fetch = TRUE
               ,stringsAsFactors = FALSE)
    
    
  }
  
  update <- function(date,group,ssn,r_sub_id)
  {
    con <- odbcDriverConnect('driver={SQL Server};server=RASIKA-PC;database=HI;trusted_connection=true')
    
    query <- "update Subscriber set Group_Sponsored = ? , Issued_date = ? , SSN = ? where Subscriber_ID = ?;"
    
    sqlExecute(con, query
               ,data = list(input$group,input$date,input$ssn,input$r_sub_id)
               ,fetch = TRUE
               ,stringsAsFactors = FALSE)
    
    
  }
  
  update_mem <- function(Marital_Status,Primary_Holder,Veteran_Status,Race,Ethnicity,Occupation
                         ,Emergency_Contact_Name,Emergency_Contact_Phone_Number,Emergency_Contact_Address_Line1
                         ,Emergency_Contact_City,Emergency_Contact_State,Emergency_Contact_Zip
                         ,Emergency_Contact_Relationship,Sub_Parent,Sub_Guardian,Subscriber_ID,r_mem_id)
  {
    con <- odbcDriverConnect('driver={SQL Server};server=RASIKA-PC;database=HI;trusted_connection=true')
    
    query <- "update Member set Marital_Status = ? ,Primary_Holder = ? ,Veteran_Status = ? ,Race =? ,Ethnicity = ? ,Occupation = ? 
    ,Emergency_Contact_Name = ? ,Emergency_Contact_Phone_Number = ? ,Emergency_Contact_Address_Line1 = ? 
    ,Emergency_Contact_City = ? ,Emergency_Contact_State = ?
    ,Emergency_Contact_Zip = ? ,Emergency_Contact_Relationship = ? ,Sub_Parent = ? ,Sub_Guardian = ? 
    ,Subscriber_ID = ? where Member_ID = ?;"
    
    sqlExecute(con, query
               ,data = list(input$mar_status
                            ,input$prime
                            ,input$vet_status
                            ,input$race
                            ,input$Ethnicity
                            ,input$Occupation
                            ,input$Ename
                            ,input$Ephone
                            ,input$Eaddress
                            ,input$Ecity
                            ,input$Estate
                            ,input$Ezip
                            ,input$Erelation
                            ,input$Sub_Parent
                            ,input$Sub_Guardian
                            ,input$Sub_ID_mem
                            ,input$r_mem_id)
               ,fetch = TRUE
               ,stringsAsFactors = FALSE)
    
    
  }
  
  #Subscriber Output
  observeEvent(input$addButton,{
    req(input$date)
    req(input$group)
    req(input$ssn)
    insert(input$date,input$group,insert$ssn)
  })
  
  observeEvent(input$uButton,{ 
    req(input$date)
    req(input$group)
    req(input$ssn)
    req(input$r_sub_id)
    update(input$group,input$date,input$ssn,input$r_sub_id)
  })
  
  observeEvent(input$delete.button,{
    req(input$Sub_ID)
    delete(input$Sub_ID)
  })
  
  output$sub_summary <- renderTable({
    req(input$sub_table)
    query <- "select * from Subscriber where Group_Sponsored = ?"
    sqlExecute(con
               ,query
               ,data = list(input$sub_table)
               ,fetch = TRUE
               ,stringsAsFactors = FALSE)
  })
  
  #Member output
  observeEvent(input$mem_addButton,{  
    
      req(input$mar_status)
      req(input$prime)
      req(input$vet_status)
      req(input$Ename )
      req(input$Ephone)
      req(input$Eaddress)
      req(input$Ecity)
      req(input$Estate)
      req(input$Erelation)
      req(input$Sub_Parent)
      req(input$Sub_Guardian)
      req(input$Sub_ID_mem)
    
    insert_mem(input$mar_status
               ,input$prime
               ,input$vet_status
               ,input$race
               ,input$Ethnicity
               ,input$Occupation
               ,input$Ename
               ,input$Ephone
               ,input$Eaddress
               ,input$Ecity
               ,input$Estate
               ,input$Ezip
               ,input$Erelation
               ,input$Sub_Parent
               ,input$Sub_Guardian
               ,input$Sub_ID_mem)
  })
  
  observeEvent(input$mem_delete.button,{  
    req(input$mem_ID)
    delete_mem(input$mem_ID)
  })
  
  observeEvent(input$mem_uButton,{  
    
    req(input$mar_status)
    req(input$prime)
    req(input$vet_status)
    req(input$Ename )
    req(input$Ephone)
    req(input$Eaddress)
    req(input$Ecity)
    req(input$Estate)
    req(input$Erelation)
    req(input$Sub_Parent)
    req(input$Sub_Guardian)
    req(input$Sub_ID_mem)
    req(input$r_mem_id)
    
    update_mem(input$mar_status
               ,input$prime
               ,input$vet_status
               ,input$race
               ,input$Ethnicity
               ,input$Occupation
               ,input$Ename
               ,input$Ephone
               ,input$Eaddress
               ,input$Ecity
               ,input$Estate
               ,input$Ezip
               ,input$Erelation
               ,input$Sub_Parent
               ,input$Sub_Guardian
               ,input$Sub_ID_mem
               ,input$r_mem_id)
  })
  
  output$mem_summary <- renderTable({
    #req(input$mem_table)
    query <- "select * from Member where Member_ID = ?;"
    sqlExecute(con
               ,query
               ,data = list(input$mem_table)
               ,fetch = TRUE
               ,stringsAsFactors = FALSE)
  })
  
})

runApp(list(ui = ui, server = server))


