# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Creating data for 'Account' table, definition as follows
# email: user's email
# role: account type differentiating normal user or administrator
# password: encrypted password stored after hashed and salted
# salt: random string used for encryption
# status: account status, including the determination of the condition before activation and after suspension 


	accounts = Account.create([
				#create users with different status
                {id:1, email:'createduser@gmail.com', role:'user', password:'12345', salt:'fngwizodkw', status:'created'},
				{id:2, email:'activeuser@gmail.com', role:'user', password:'12345', salt:'asdnbkwekd', status:'active'},
				{id:3, email:'suspendeduser@gmail.com', role:'user', password:'12345', salt:'23#*$@skdbf', status:'suspended'},
				{id:4, email:'banneduser@gmail.com', role:'user', password:'12345', salt:'weng234bsdf38sdf', status:'banned'},
				
				#create a testing user
				#{id:5, email:'raymondfzy@gmail.com', role:'user', password:'12345', salt:'asdnbkwekd', status:'active'},

				#create admins with different status
				{id:6, email:'zeyu.feng@mail.utoronto.ca', role:'admin', password:'12345', salt:'sfnweuigg', status:'created'},
                {id:7, email:'geling.li@mail.utoronto.ca', role:'admin', password:'12345', salt:'sadfrgmis', status:'active'},
                {id:8, email:'zikevin.wang@mail.utoronto.ca', role:'admin', password:'12345', salt:'238syiladfn', status:'suspended'},
				{id:9, email:'da.fu@mail.utoronto.ca', role:'admin', password:'12345', salt:'43jhisgdbn', status:'banned'},
                {id:10, email:'shuer.li@mail.utoronto.ca', role:'admin', password:'12345', salt:'43jhisgdbn', status:'active'},
				{id:11, email:'qingqing.zhuo@mail.utoronto.ca', role:'admin', password:'12345', salt:'gweknz238hsdf', status:'active'},
			])


# Creating data for 'Profile' table, definition as follows
# email: user's email
# first_name: user's first name
# middle_name: user's middle name
# last_name: user's last name
# display_name: user's nickname or other name showed to public 
# phone_number: user's phone number
# gender: user's gender
# languages: user's preferred languages for communicating
# country: user's residence country
# facebook: user's facebook link
# gmail: user's gmail link
# twitter: user's twitter link
# avatar_url: url targeting to user's profile picture file
# interest: user's personal hobbies


	profiles = Profile.create([
			#create profiles for each user
			{email:'createduser@gmail.com', display_name: 'created1', language: 'English', avatar_url: 'https://cdn.onlinewebfonts.com/svg/img_311846.png'},
			{email:'activeuser@gmail.com', first_name: 'Jiro', last_name: 'Active', display_name: 'active2', language: 'English', country:'USA', avatar_url: 'https://cdn.onlinewebfonts.com/svg/img_311846.png'},
			{email:'suspendeduser@gmail.com', first_name: 'Saburo', last_name: 'Suspended', display_name: 'suspended3', language: 'English', country:'England', avatar_url: 'https://cdn.onlinewebfonts.com/svg/img_311846.png'},
			{email:'activeuser@gmail.com', first_name: 'Shiro', last_name: 'Banned', display_name: 'banned4', language: 'English', avatar_url: 'https://cdn.onlinewebfonts.com/svg/img_311846.png'},
			{email:'raymondfzy@gmail.com', first_name:'Yu', middle_name:'Ze', last_name:'Feng', display_name:'Yu F',phone_number:'6478673581', gender:'Male', language:'Chinese', country:'Canada', facebook:'https://www.facebook.com/profile.php?id=100007708830271', google:'raymondfzy@gmail.com', avatar_url:'https://vignette.wikia.nocookie.net/bhlx/images/2/20/Tirpitz.jpg/revision/latest?cb=20170824110929', interest:'Games'},
			
			#create a profile for admin
			{email:'zeyu.feng@mail.utoronto.ca', display_name:'admZY',language:'Chinese', avatar_url: 'https://cdn.onlinewebfonts.com/svg/img_311846.png'}
	])



# Creating data for 'Address' table, definition as follows
# address_id: identifier for each address entry
# email: user's email
# address_line1: Street and street number
# address_line2: Apartment, suite, unit, building, etc.
# city: city
# province: province/states
# country: country
# postal_code: postal code
	addresses = Address.create([
			#create three different addresses for an active user
			{email:'raymondfzy@gmail.com', address_line1: '211-325 South Park Rd', city:'Thornhill', province:'Ontario', country: 'Canada', postal_code:'L3T 0B8'},
			{email:'raymondfzy@gmail.com', address_line1: '212-325 South Park Rd', city:'Thornhill', province:'Ontario', country: 'Canada', postal_code:'L3T 0B8'},
			{email:'raymondfzy@gmail.com', address_line1: '213-325 South Park Rd', city:'Thornhill', province:'Ontario', country: 'Canada', postal_code:'L3T 0B8'},
			
			#create addresses for users with other status
			{email:'createduser@gmail.com', address_line1: '211-325 South Park Rd', city:'Thornhill', province:'Ontario', country: 'Canada', postal_code:'L3T 0B8'},
			{email:'suspendeduser@gmail.com', address_line1: '211-325 South Park Rd', city:'Thornhill', province:'Ontario', country: 'Canada', postal_code:'L3T 0B8'},
			{email:'banneduser@gmail.com', address_line1: '211-325 South Park Rd', city:'Thornhill', province:'Ontario', country: 'Canada', postal_code:'L3T 0B8'},
	])


# Creating data for 'Category' table, definition as follows
# category_id: identifier for each category entry
# department: name of department which this category belongs to, referencing to Walmart/Amazon/Ebay
# name: name of this category, referencing to Walmart/Amazon/Ebay
category1 = Category.create!(department:'Books', name:'Textbooks')
category2 = Category.create!(department:'Books', name:'Novels')
category3 = Category.create!(department:'Video Games', name: 'PC Gaming')
category4 = Category.create!(department:'Electronics', name:'Tv & Video')


# Creating data for 'Item' table, definition as follows
# owner: email of the user owning this item
# condition: item condition, referenced to the standard on Ebay
# category: category_id with corresponding item category
# rating_level: minimum credit requirement on borrowers
# address_option: available pick-up locations
# time_start: the first day that the item is available for borrowing
# time_end: the last day that the item is available for borrowing
# time_pickup: available pick-up time

category1.items.create!([
                       {owner:'raymondfzy@gmail.com', condition:'Brand New', rate_level: 4, time_start:'2018-11-12 00:00:00', time_end: '2018-12-25 13:23:04', name:'Introduction to Database', description:'A brand new textbook, whoever uses it will likely get 4.0 gpa on that course', brand:'brand1'},
                       {owner:'raymondfzy@gmail.com', condition:'Like New', rate_level: 5, time_start:'2018-12-12 00:00:00', time_end: '2018-12-26 13:23:04', name:'Introduction to algorithm', description:'used textbook', brand:'brand2'},
                       {owner:'createduser@gmail.com', condition:'Brand New',time_start:'2018-11-12 00:00:00', time_end: '2018-12-25 13:23:04', name:'Quantum Mechanics', description:'slaknfw93*(&%^&@#)(Unkasbfjweo',brand:'Sciencene'},
                       {owner:'geling.li@mail.utoronto.ca', condition:'Like New', time_start:'2018-11-12 00:00:00', time_end: '2018-12-25 13:23:04', name:'Learn C++ in 21 Days', description:'This dude is lazy and did not leave anything here', brand:'XinHua'}
                       ])

category2.items.create!([
                    {owner:'raymondfzy@gmail.com', condition:'Very Good', rate_level: 3, time_start:'2018-11-16 00:00:00', time_end: '2018-12-23 13:23:04', name:'King Lear',description:'see the picture', brand:'brand3'},
                    {owner:'raymondfzy@gmail.com', condition:'Good', rate_level: 2, time_start:'2018-11-08 00:00:00', time_end: '2019-01-25 13:23:04', name:'Don Quixote', description:'This dude is lazy and did not leave anything here', brand:'brand4'},
                    {owner:'suspendeduser@gmail.com', condition:'Brand New', time_start:'2018-11-12 00:00:00', time_end: '2018-12-25 13:23:04', name:'Frankenstein', description:'frank', brand:'brand3'}
                       ])

category3.items.create!([
                    {owner:'raymondfzy@gmail.com', condition:'Adequate', time_start:'2018-11-12 00:00:00', time_end: '2018-12-25 13:23:04', name:'Halo 7',description:'This dude is lazy and did not leave anything here',brand:'brand1'},
                    {owner:'raymondfzy@gmail.com', condition:'Defective', time_start:'2018-11-12 00:00:00', time_end: '2018-12-25 13:23:04', name:'Resident Evil',description:'This dude is lazy and did not leave anything here',brand:'brand1'},
                    {owner:'banneduser@gmail.com', condition:'Brand New', time_start:'2018-11-12 00:00:00', time_end: '2018-12-25 13:23:04', name:'Monster Hunter', description:'3ds version', brand:'Kapkom'},
                    {owner:'geling.li@mail.utoronto.ca', condition:'Good', time_start:'2018-11-12 00:00:00', time_end: '2018-12-25 13:23:04', name:'Tomb Raider', description:'The best one of the series', brand:'3DM Private Games'}
                    ])


# Creating data for 'Request' table, definition as follows
# request_id: identifier for each request relationship
# item_id: identifier of the item connected with this borrowing request
# lender: the email of user who want to borrow this item
# address: final address for pick-up
# status: current status of this request
# rejected_reason: reason of rejection for lending, if any
# time_start: the first day that the item is borrowed
# time_end: the last day that the item is borrowed
# time_pickup: final time for pick-up
# received: whether the borrower received this item
# returned: whether the borrower returned this item

	requests = Request.create([
		#requests from active users/admin to active owners
		{item_id:1, borrower:'activeuser@gmail.com', address:1, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:2, borrower:'activeuser@gmail.com', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:3, borrower:'activeuser@gmail.com', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:4, borrower:'activeuser@gmail.com', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:5, borrower:'activeuser@gmail.com', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:6, borrower:'activeuser@gmail.com', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:1, borrower:'geling.li@mail.utoronto.ca', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		

		#requests from inactive users to active owners
		{item_id:1, borrower:'createduser@gmail.com', address:1, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:2, borrower:'suspendeduser@gmail.com', address:1, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:3, borrower:'banneduser@gmail.com', address:1, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},

		#requests from active users/admin to inactive owners
		{item_id:7, borrower:'activeuser@gmail.com', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:8, borrower:'activeuser@gmail.com', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:9, borrower:'activeuser@gmail.com', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:7, borrower:'geling.li@mail.utoronto.ca', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:8, borrower:'geling.li@mail.utoronto.ca', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:9, borrower:'geling.li@mail.utoronto.ca', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'}
	])




# Creating data for 'FeedbackToBorrower' table, definition as follows
# id: identifier of Feedback To Borrower
# request_id: identifier of the request which this feedback connected to
# rate: numerial score out of 5 to borrower 
# tag: neat comment given to the borrower
# credit: total score given to this user
# comment: text feedback, if any


	feedbackToBorrowers = FeedbackToBorrower.create([
		{request_id:1, rate:4, credit:4, comment:'good'},
		{request_id:8, rate:4, credit:4, comment:'good 2'},
		{request_id:12, rate:5, credit:4}
	])


# Creating data for 'FeedbackToLender' table, definitions as follows
# id: identifier of Feedback To Lender
# request_id: identifier of the request which this feedback connected to
# rate: numerial score out of 5 to lender 
# tag: neat comment given to the lender
# credit: total credit given to this user
# comment: text feedback, if any
 	feedbackToLenders = FeedbackToLender.create([
 		{request_id:1, rate:5, credit:2, comment:'This lender is great'},
		{request_id:8, rate:3, credit:2, comment:'That lender is great 2'},
		{request_id:12, rate:3, credit:4}
	])


# Creating data for 'Report' table, definition as follows
# report_id: identifer of each report entry
# type: report type
# subject: main topic of this report
# content: report content
# status: the status of processing on this report
# handler: email of the administrator who handle this report
# request_id: id of the request connected with this report, if any
	reports = Report.create([
			#create all types of reports with all types of status, active admin handler
			{report_type: 'system', subject:'system report subject1', content:'random complains about system problems', status:'submitted',handler: 'geling.li@mail.utoronto.ca', time_submitted:'2018-09-23 00:00:00'},
			{report_type: 'system', subject:'system report subject2', content:'random complains about system problems', status:'in progress',handler: 'geling.li@mail.utoronto.ca', time_submitted:'2018-09-23 00:00:00'},
			{report_type: 'system', subject:'system report subject3', content:'random complains about system problems', status:'resolved',handler: 'geling.li@mail.utoronto.ca', time_submitted:'2018-09-23 00:00:00'},
			{report_type: 'client', subject:'client report subject1', content:'random complains about client problems', status:'submitted',handler: 'geling.li@mail.utoronto.ca', time_submitted:'2018-09-23 00:00:00'},
			{report_type: 'client', subject:'client report subject2', content:'random complains about client problems', status:'in progress',handler: 'geling.li@mail.utoronto.ca', time_submitted:'2018-09-23 00:00:00'},
			{report_type: 'client', subject:'client report subject3', content:'random complains about client problems', status:'resolved',handler: 'geling.li@mail.utoronto.ca', time_submitted:'2018-09-23 00:00:00'},
			{report_type: 'suggestion', subject:'suggestion report subject1', content:'random complains about suggestion problems', status:'submitted',handler: 'geling.li@mail.utoronto.ca', time_submitted:'2018-09-23 00:00:00'},
			{report_type: 'suggestion', subject:'suggestion report subject2', content:'random complains about suggestion problems', status:'in progress',handler: 'geling.li@mail.utoronto.ca', time_submitted:'2018-09-23 00:00:00'},
			{report_type: 'suggestion', subject:'suggestion report subject3', content:'random complains about suggestion problems', status:'resolved',handler: 'geling.li@mail.utoronto.ca', time_submitted:'2018-09-23 00:00:00'},

			#create reports with created, suspended and banned admin handler
			{report_type: 'system', subject:'system report - created admin1', content:'random complains', status:'submitted',handler: 'zeyu.feng@mail.utoronto.ca', time_submitted:'2018-09-23 00:00:00'},
			{report_type: 'system', subject:'system report - created admin2', content:'random complains', status:'in progress',handler: 'zeyu.feng@mail.utoronto.ca', time_submitted:'2018-09-23 00:00:00'},
			{report_type: 'client', subject:'client report - suspended admin1', content:'random complains', status:'submitted',handler: 'zikevin.wang@mail.utoronto.ca', time_submitted:'2018-09-23 00:00:00'},
			{report_type: 'client', subject:'client report - suspended admin2', content:'random complains', status:'in progress',handler: 'zikevin.wang@mail.utoronto.ca', time_submitted:'2018-09-23 00:00:00'},
			{report_type: 'suggestion', subject:'suggestion report - banned admin1', content:'random complains', status:'submitted',handler: 'da.fu@mail.utoronto.ca', time_submitted:'2018-09-23 00:00:00'},
			{report_type: 'suggestion', subject:'suggestion report - banned admin2', content:'random complains', status:'in progress',handler: 'da.fu@mail.utoronto.ca', time_submitted:'2018-09-23 00:00:00'}
	])



# Creating data for 'Chat' table
	chats = Chat.create([
			{time:'2018-09-20 19:00:00', sender:'zeyu.feng@mail.utoronto.ca', receiver:'zikevin.wang@mail.utoronto.ca', content: 'Hi'},
			{time:'2018-09-22 19:00:00', sender:'da.fu@mail.utoronto.ca', receiver:'zikevin.wang@mail.utoronto.ca', content: 'Hola'},
			{time:'2018-09-23 19:00:00', sender:'geling.li@mail.utoronto.ca', receiver:'da.fu@mail.utoronto.ca', content: 'Bonjour'},
			{time:'2018-09-24 19:00:00', sender:'geling.li@mail.utoronto.ca', receiver:'zeyu.feng@mail.utoronto.ca', content: 'Privet'},
			{time:'2018-09-20 19:00:00', sender:'zeyu.feng@mail.utoronto.ca', receiver:'da.fu@mail.utoronto.ca', content: 'konchya'}
	])


