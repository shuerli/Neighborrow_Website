# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


accounts = Account.create([
                          {email:'raymondfzy@gmail.com', email_confirmed:true, role:'user', password:'12345', salt:'asdnbkwekd', status:'active'},
                          {email:'zeyu.feng@mail.utoronto.ca', email_confirmed:true, role:'admin', password:'12345', salt:'sfnweuigg', status:'created'},
                          {email:'geling.li@mail.utoronto.ca', email_confirmed:true, role:'admin', password:'12345', salt:'sadfrgmis', status:'active'},
                          {email:'zikevin.wang@mail.utoronto.ca', email_confirmed:true, role:'admin', password:'12345', salt:'238syiladfn', status:'suspended'},
                          {email:'shuer.li@mail.utoronto.ca', email_confirmed:true, role:'admin', password:'12345', salt:'43jhisgdbn', status:'active'},
                          {email:'qingqing.zhuo@mail.utoronto.ca', email_confirmed:true, role:'admin', password:'12345', salt:'gweknz238hsdf', status:'active'},
						  ])
						  
profiles = Profile.create([
							#create profiles for each user
							{email:'raymondfzy@gmail.com', first_name:'Yu', middle_name:'Ze', last_name:'Feng', display_name:'Yu F',phone_number:'6478673581', gender:'Male', language:'Chinese', country:'Canada', facebook:'https://www.facebook.com/profile.php?id=100007708830271', google:'raymondfzy@gmail.com', avatar_url:'https://vignette.wikia.nocookie.net/bhlx/images/2/20/Tirpitz.jpg/revision/latest?cb=20170824110929', interest:'Games'},
							{email:'zeyu.feng@mail.utoronto.ca', display_name:'admZY',language:'Chinese', avatar_url: 'https://cdn.onlinewebfonts.com/svg/img_311846.png'},
							{email:'geling.li@mail.utoronto.ca', display_name: 'geling', language: 'English', country:'USA', avatar_url: 'https://cdn.onlinewebfonts.com/svg/img_311846.png'},
							{email:'zikevin.wang@mail.utoronto.ca', display_name: 'zikevin', language: 'English', avatar_url: 'https://cdn.onlinewebfonts.com/svg/img_311846.png'},
							{email:'shuer.li@mail.utoronto.ca', display_name:'shuer',phone_number:'6478673581', gender:'Male', language:'Chinese', country:'Canada', avatar_url: 'https://cdn.onlinewebfonts.com/svg/img_311846.png'},
							{email:'qingqing.zhuo@mail.utoronto.ca', display_name:'qingqing', phone_number:'6478673581', gender:'Male', language:'Chinese', country:'Canada', avatar_url: 'https://cdn.onlinewebfonts.com/svg/img_311846.png'},
							])


addresses = Address.create!([
							#create three different addresses for an active user
							{email:'raymondfzy@gmail.com', address_line1: '211-325 South Park Rd', city:'Thornhill', province:'Ontario', country: 'Canada', postal_code:'L3T 0B8'},
							{email:'zikevin.wang@mail.utoronto.ca', address_line1: '601-325 South Park Rd', city:'Thornhill', province:'Ontario', country: 'Canada', postal_code:'L3T 0B8'},
							{email:'raymondfzy@gmail.com', address_line1: '907-222 Elm Street', city:'Toronto', province:'Ontario', country: 'Canada', postal_code:'M5T 1K5'},
							{email:'zikevin.wang@mail.utoronto.ca', address_line1: '510-200 Elm Street', city:'Toronto', province:'Ontario', country: 'Canada', postal_code:'M5T 1K4'}
							{email:'raymondfzy@gmail.com', address_line1: '2058 Ellesmere Rd', city:'Scarborough', province:'Ontario', country: 'Canada', postal_code:'M1H 2V6'},
							{email:'zikevin.wang@mail.utoronto.ca', address_line1: '2055 Ellesmere Rd', city:'Scarborough', province:'Ontario', country: 'Canada', postal_code:'M1H 2V6'}
							])

departments = Department.create([
                                {name:'Home, Garden, Pets & Tools'},
                                {name:'Books & Audible'},
                                {name:'Electronics, Computers & Office'},
                                {name:'Automotive & Industrial'},
                                {name:'Toys, Kids, Baby & STEM'},
                                {name:'Clothing, Shoes & Jewelry'},
                                {name:'Sports & Outdoors'},
                                {name:'Music, Movies & TV Shows'},
								])
								
categories = Category.create([	
								{department:'Miscellaneous', name:'Miscellaneous'},

								{department:'Video Games', name:'PC Games'},
								{department:'Video Games', name:'Console Games'},
								{department:'Video Games', name:'Controller & Devices'},

								{department:'Books & Audible', name:'Textbooks'},
								{department:'Books & Audible', name:'Children\'s Books'},
								{department:'Books & Audible', name:'Novels'},
								{department:'Books & Audible', name:'Comics & Manga'},
								{department:'Books & Audible', name:'Food & Travel'},

								{department:'Music, Movies & TV Shows', name:'Blu-ray'},
								{department:'Music, Movies & TV Shows', name:'New Releases'},
								{department:'Music, Movies & TV Shows', name:'All Music'},

								{department:'Electronics, Computers & Office', name:'Printers & Ink'},
								{department:'Electronics, Computers & Office', name:'PC Components'},
								{department:'Electronics, Computers & Office', name:'Computer Accessories'},
								{department:'Electronics, Computers & Office', name:'Camera, Photo & Video'},
								{department:'Electronics, Computers & Office', name:'Monitors & Speakers'},
								{department:'Electronics, Computers & Office', name:'Software'},

								{department:'Home, Garden, Pets & Tools',  name: 'Storage & Organization'},
								{department:'Home, Garden, Pets & Tools',  name: 'All Kitchen'},
								{department:'Home, Garden, Pets & Tools',  name: 'Household Supplies'},
								{department:'Home, Garden, Pets & Tools',  name: 'Garden'},
								{department:'Home, Garden, Pets & Tools',  name: 'All Pets'},
								{department:'Home, Garden, Pets & Tools',  name: 'Home Decor'},
								{department:'Home, Garden, Pets & Tools',  name: 'All Tools'},

								{department:'Toys, Kids & Baby',  name: 'Outdoor Play'},
								{department:'Toys, Kids & Baby',  name: 'Toys'},
								{department:'Toys, Kids & Baby',  name: 'All Baby'},

								{department:'Clothing & Jewelry',  name: 'Boys'},
								{department:'Clothing & Jewelry',  name: 'Girls'},
								{department:'Clothing & Jewelry',  name: 'Accessories'},

								{department:'Sports & Outdoors', name: 'Fishing'},
								{department:'Sports & Outdoors', name: 'Golf'},
								{department:'Sports & Outdoors', name: 'Camping & Hiking'},
								{department:'Sports & Outdoors', name: 'Cycling'},
								{department:'Sports & Outdoors', name: 'Water Sports'},
								{department:'Sports & Outdoors', name: 'Winter Sports'},
								
								{department:'Automotive', name: 'Maintenance & Care'},
								{department:'Automotive', name: 'All Automotive'}
							])


items = Item.create!([
					{category_id:'4',owner:'raymondfzy@gmail.com', photo_url:'/assets/img/imgplaceholder.gif', condition:'Brand New', rate_level: 4, time_start:'2018-11-12 00:00:00', time_end: '2018-12-25 13:23:04', name:'Introduction to Database', description:'A brand new textbook, whoever uses it will likely get 4.0 gpa on that course', brand:'brand1'},
                       {category_id:'4',owner:'raymondfzy@gmail.com', photo_url:'/assets/img/imgplaceholder.gif', condition:'Like New', rate_level: 5, time_start:'2018-12-12 00:00:00', time_end: '2018-12-26 13:23:04', name:'Introduction to algorithm', description:'used textbook', brand:'brand2'},
                       {category_id:'4',owner:'createduser@gmail.com', photo_url:'/assets/img/imgplaceholder.gif', condition:'Brand New',time_start:'2018-11-12 00:00:00', time_end: '2018-12-25 13:23:04', name:'Quantum Mechanics', description:'slaknfw93*(&%^&@#)(Unkasbfjweo',brand:'Sciencene'},
					   {category_id:'3',owner:'geling.li@mail.utoronto.ca', photo_url:'/assets/img/imgplaceholder.gif', condition:'Like New', time_start:'2018-11-12 00:00:00', time_end: '2018-12-25 13:23:04', name:'Learn C++ in 21 Days', description:'This dude is lazy and did not leave anything here', brand:'XinHua'},
					   {category_id:'3',owner:'raymondfzy@gmail.com', photo_url:'/assets/img/imgplaceholder.gif', condition:'Very Good', rate_level: 3, time_start:'2018-11-16 00:00:00', time_end: '2018-12-23 13:23:04', name:'King Lear',description:'see the picture', brand:'brand3'},
                    {category_id:'3',owner:'raymondfzy@gmail.com', photo_url:'/assets/img/imgplaceholder.gif', status:'lent', condition:'Good', rate_level: 2, time_start:'2018-11-08 00:00:00', time_end: '2019-01-25 13:23:04', name:'Don Quixote', description:'This dude is lazy and did not leave anything here', brand:'brand4'},
					{category_id:'3',owner:'suspendeduser@gmail.com', photo_url:'/assets/img/imgplaceholder.gif', status:'lent', condition:'Brand New', time_start:'2018-11-12 00:00:00', time_end: '2018-12-25 13:23:04', name:'Frankenstein', description:'frank', brand:'brand3'},
					{category_id:'2',owner:'raymondfzy@gmail.com', photo_url:'/assets/img/imgplaceholder.gif',status:'lent', condition:'Adequate', time_start:'2018-11-12 00:00:00', time_end: '2018-12-25 13:23:04', name:'Halo 7',description:'This dude is lazy and did not leave anything here',brand:'brand1'},
                    {category_id:'2',owner:'raymondfzy@gmail.com', photo_url:'/assets/img/imgplaceholder.gif', condition:'Defective', time_start:'2018-11-12 00:00:00', time_end: '2018-12-25 13:23:04', name:'Resident Evil',description:'This dude is lazy and did not leave anything here',brand:'brand1'},
                    {category_id:'2',owner:'banneduser@gmail.com', photo_url:'/assets/img/imgplaceholder.gif', condition:'Brand New', time_start:'2018-11-12 00:00:00', time_end: '2018-12-25 13:23:04', name:'Monster Hunter', description:'3ds version', brand:'Kapkom'},
                    {category_id:'2',owner:'geling.li@mail.utoronto.ca', photo_url:'/assets/img/imgplaceholder.gif', condition:'Good', time_start:'2018-11-12 00:00:00', time_end: '2018-12-25 13:23:04', name:'Tomb Raider', description:'The best one of the series', brand:'3DM Private Games'}
                    ])

requests = Request.create([
		{item_id:1, borrower:'raymondfzy@gmail.com', address:1, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:2, borrower:'raymondfzy@gmail.com', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:3, borrower:'raymondfzy@gmail.com', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:4, borrower:'raymondfzy@gmail.com', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:5, borrower:'raymondfzy@gmail.com', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:6, borrower:'raymondfzy@gmail.com', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:1, borrower:'geling.li@mail.utoronto.ca', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		
		{item_id:1, borrower:'raymondfzy@gmail.com', address:1, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:2, borrower:'raymondfzy@gmail.com', address:1, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:3, borrower:'raymondfzy@gmail.com', address:1, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},

		{item_id:7, borrower:'raymondfzy@gmail.com', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:8, borrower:'raymondfzy@gmail.com', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:9, borrower:'raymondfzy@gmail.com', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:7, borrower:'geling.li@mail.utoronto.ca', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:8, borrower:'geling.li@mail.utoronto.ca', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:9, borrower:'geling.li@mail.utoronto.ca', address:2, time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'}
	])


feedbackToBorrowers = FeedbackToBorrower.create([
		{request_id:1, rate:4, credit:4, comment:'good'},
		{request_id:8, rate:4, credit:4, comment:'good 2'},
		{request_id:12, rate:5, credit:4}
	])


feedbackToLenders = FeedbackToLender.create([
 		{request_id:1, rate:5, credit:2, comment:'This lender is great'},
		{request_id:8, rate:3, credit:2, comment:'That lender is great 2'},
		{request_id:12, rate:3, credit:4}
	])


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




chats = Chat.create([
			{time:'2018-09-20 19:00:00', sender:'zeyu.feng@mail.utoronto.ca', receiver:'zikevin.wang@mail.utoronto.ca', content: 'Hi'},
			{time:'2018-09-22 19:00:00', sender:'da.fu@mail.utoronto.ca', receiver:'zikevin.wang@mail.utoronto.ca', content: 'Hola'},
			{time:'2018-09-23 19:00:00', sender:'geling.li@mail.utoronto.ca', receiver:'da.fu@mail.utoronto.ca', content: 'Bonjour'},
			{time:'2018-09-24 19:00:00', sender:'geling.li@mail.utoronto.ca', receiver:'zeyu.feng@mail.utoronto.ca', content: 'Privet'},
			{time:'2018-09-20 19:00:00', sender:'zeyu.feng@mail.utoronto.ca', receiver:'da.fu@mail.utoronto.ca', content: 'konchya'}
	])