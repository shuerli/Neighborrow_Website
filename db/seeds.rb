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
							{email:'zikevin.wang@mail.utoronto.ca', address_line1: '510-200 Elm Street', city:'Toronto', province:'Ontario', country: 'Canada', postal_code:'M5T 1K4'},
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
								#1
								{department:'Miscellaneous', name:'Miscellaneous'},
								
								#2
								{department:'Video Games', name:'PC Games'}, 
								#3
								{department:'Video Games', name:'Console Games'},
								#4
								{department:'Video Games', name:'Controller & Devices'},

								#5
								{department:'Books & Audible', name:'Textbooks'},
								#6
								{department:'Books & Audible', name:'Children\'s Books'},
								#7
								{department:'Books & Audible', name:'Novels'},
								#8
								{department:'Books & Audible', name:'Comics & Manga'},
								#9
								{department:'Books & Audible', name:'Food & Travel'},

								#10
								{department:'Music, Movies & TV Shows', name:'Blu-ray'},
								#11
								{department:'Music, Movies & TV Shows', name:'New Releases'},
								#12
								{department:'Music, Movies & TV Shows', name:'All Music'},

								#13
								{department:'Electronics, Computers & Office', name:'Printers & Ink'},
								#14
								{department:'Electronics, Computers & Office', name:'PC Components'},
								#15
								{department:'Electronics, Computers & Office', name:'Computer Accessories'},
								#16
								{department:'Electronics, Computers & Office', name:'Camera, Photo & Video'},
								#17
								{department:'Electronics, Computers & Office', name:'Monitors & Speakers'},
								#18
								{department:'Electronics, Computers & Office', name:'Software'},

								#19
								{department:'Home, Garden, Pets & Tools',  name: 'Storage & Organization'},
								#20
								{department:'Home, Garden, Pets & Tools',  name: 'All Kitchen'},
								#21
								{department:'Home, Garden, Pets & Tools',  name: 'Household Supplies'},
								#22
								{department:'Home, Garden, Pets & Tools',  name: 'Garden'},
								#23
								{department:'Home, Garden, Pets & Tools',  name: 'All Pets'},
								#24
								{department:'Home, Garden, Pets & Tools',  name: 'Home Decor'},
								#25
								{department:'Home, Garden, Pets & Tools',  name: 'All Tools'},

								#26
								{department:'Toys, Kids & Baby',  name: 'Outdoor Play'},
								#27
								{department:'Toys, Kids & Baby',  name: 'Toys'},
								#28
								{department:'Toys, Kids & Baby',  name: 'All Baby'},

								#29
								{department:'Clothing & Jewelry',  name: 'Boys'},
								#30
								{department:'Clothing & Jewelry',  name: 'Girls'},
								#31
								{department:'Clothing & Jewelry',  name: 'Accessories'},

								#32
								{department:'Sports & Outdoors', name: 'Fishing'},
								#33
								{department:'Sports & Outdoors', name: 'Golf'},
								#34
								{department:'Sports & Outdoors', name: 'Camping & Hiking'},
								#35
								{department:'Sports & Outdoors', name: 'Cycling'},
								#36
								{department:'Sports & Outdoors', name: 'Water Sports'},
								#37
								{department:'Sports & Outdoors', name: 'Winter Sports'},
								
								#38
								{department:'Automotive', name: 'Maintenance & Care'},
								#39
								{department:'Automotive', name: 'All Automotive'}
							])


items = Item.create!([
					{category_id:'2',
					address:1,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Video Games/Assassin.jpeg', 
					condition:'Good', 
					rate_level: 4, 
					time_start:'2018-12-25 00:00:00', 
					time_end: '2019-01-15 00:00:00', 
					name:'Assassin\'s Creed 4 CD', 
					description:'I will share my games when I\'m away during Christmas. The game is in CD, you will need a disk reader to install and play it.',
					brand:'Ubisoft'
					},

					{category_id:'2',
					address:3,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Video Games/civ6.jpeg', 
					condition:'Like New', 
					rate_level: 4, 
					time_start:'2018-12-25 00:00:00', 
					time_end: '2019-01-15 00:00:00', 
					name:'Civilizaion 6 CD', 
					description:'I will share my games when I\'m away during Christmas. The game is in CD, you will need a disk reader to install and play it.', 
					brand:'2K Games',
					},

					{category_id:'2',
					address:1,
					owner:'raymondfzy@gmail.com', 
					status:'lent',
					photo_url:'/assets/img/Video Games/GoW4.jpeg', 
					condition:'Like New', 
					rate_level: 5, 
					time_start:'2018-12-25 00:00:00', 
					time_end: '2019-01-15 00:00:00', 
					name:'Gears of War 4 digital version', 
					description:'Sharing my games while I\'m away during Christmas. This game is in my account, so you can enjoy the game on my account and earn me some battle points. Please request it if you play A LOT.', 
					brand:'Microsoft'},

					{category_id:'2',
					address:3,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Video Games/GTA5.jpeg', 
					condition:'Good', 
					rate_level: 4, 
					time_start:'2018-12-25 00:00:00', 
					time_end: '2019-01-15 00:00:00', 
					name:'GTA 5', 
					description:'Sharing my games during Christmas. Just remember don\'t start a new game cuz it will overwrite my saved game.', 
					brand:'Rock Star'},

					{category_id:'2',
					address:5,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Video Games/MHWPC.jpeg', 
					condition:'Brand New', 
					rate_level: 5, 
					time_start:'2018-12-25 00:00:00', 
					time_end: '2019-01-15 00:00:00', 
					name:'Monster Hunter World in steam account', 
					description:'Sharing my games while I\'m away during Christmas. This game is in my steam account, I will share my password once I accept your request, if you are able to clear stage 5 for me.', 
					brand:'Capcom'},

					{category_id:'2',
					address:3,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Video Games/PVZGW2PC.jpeg', 
					condition:'Very Good', 
					rate_level: 4, 
					time_start:'2018-12-25 00:00:00', 
					time_end: '2019-01-15 00:00:00', 
					name:'Plants VS Zombies GW2 PC', 
					brand:'EA'},
					

					{category_id:'3',
					address:1,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Video Games/PVZGW2PS4.jpeg', 
					condition:'Very Good', 
					rate_level: 4, 
					time_start:'2018-12-25 00:00:00', 
					time_end: '2019-01-15 00:00:00', 
					name:'Plants VS Zombies GW2 on ps4', 
					description:'You can play local games with your friend(split screen mode), but online play will require your own psn subscription.',
					brand:'EA'},

					{category_id:'3',
					address:1,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Video Games/Tokiden2.jpeg', 
					condition:'Good', 
					rate_level: 1, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2099-01-01 00:00:00', 
					name:'Tokiden 2 ps4 disk', 
					description:'The game is just too hard. I actually won\'t be playing it anymore, you can keep it as long as you want.',
					brand:'KoeiTecmo'},

					{category_id:'3',
					address:3,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Video Games/gbasp3ds.jpeg', 
					condition:'Good', 
					rate_level: 3, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2019-06-01 00:00:00', 
					name:'GBA SP and 3DS consoles', 
					description:'I only have the two consoles, you need to get games by yourself. I will be moving in summer 2019 so please give it back by then.',
					brand:'Nintendo'},

					{category_id:'3',
					address:5,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Video Games/GBC.jpeg', 
					condition:'Adequate', 
					rate_level: 2, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2019-06-01 00:00:00', 
					name:'Gameboy Color console and Pokemon Gen 1', 
					description:'You will need to by batteries for it. It comes with a game so don\'t worry about getting games, I will be moving in summer 2019 so please give it back by then.',
					brand:'Nintendo'},

					{category_id:'4',
					address:1,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Video Games/Xbox360motion.jpeg', 
					condition:'Very Good', 
					rate_level: 5, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2019-06-01 00:00:00', 
					name:'Xbox Kinect', 
					description:'Kinect controller, I play the games myself but I \'m tired of motion controller, so no games or console with it. I will be moving in summer 2019 so please give it back by then.',
					brand:'Microsoft'},

					{category_id:'4',
					address:1,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Video Games/SwitchPro.jpeg', 
					condition:'Good', 
					rate_level: 4, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2019-01-01 00:00:00', 
					name:'Switch Pro controller', 
					brand:'Nintendo'},
					
					{category_id:'4',
					address:3,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Video Games/PS4Controller.jpeg', 
					condition:'Very Good', 
					rate_level: 4, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2019-03-12 00:00:00', 
					name:'duel shock 4 ps4 controller', 
					description:'A spare one. Anyone can borrow it if your friend comes over, but must return it by the next day of borrow',
					brand:'Sony'},

					{category_id:'5',
					address:1,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Books/1styear.jpeg', 
					condition:'Defective', 
					rate_level: 1, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2019-12-01 00:00:00', 
					name:'First year university math books', 
					description:'Some math textbooks I used in first year, it is helpful in general but you may or may not need all the topics in it. Some pages are stained but most of the content is readable.',
					},

					{category_id:'5',
					address:3,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Books/algo.jpeg', 
					condition:'Like New', 
					rate_level: 4, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2019-05-01 00:00:00', 
					name:'Introduction to Algorithms', 
					description:'It is THE bible of algorithms, no need to say more.',
					},

					{category_id:'5',
					address:1,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Books/chinese.jpeg', 
					condition:'Adequate', 
					rate_level: 2, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2019-03-12 00:00:00', 
					name:'Chinese language learning textbooks', 
					description:'There is couple of them, you can take them all.',
					},

					{category_id:'5',
					address:5,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Books/medphy.jpeg', 
					condition:'Very Good', 
					rate_level: 3, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2019-03-12 00:00:00', 
					name:'Medical Physiology', 
					},

					{category_id:'6',
					address:5,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Books/green.jpeg', 
					condition:'Good', 
					rate_level: 3, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2019-05-12 00:00:00', 
					name:'The Green Fairy Book', 
					description:'It comes in two parts. Very good for kids to read.',
					},

					{category_id:'6',
					address:5,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Books/green2.jpeg', 
					condition:'Good', 
					rate_level: 3, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2019-03-12 00:00:00', 
					name:'The Green Fairy Book by Andrew Lang', 
					},

					{category_id:'6',
					address:3,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Books/snow.jpeg', 
					condition:'Adequate', 
					rate_level: 2, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2019-02-15 00:00:00', 
					name:'Snow white book',
					description:'My favorite story, a great book for kids.' ,
					},

					{category_id:'6',
					address:5,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Books/doraeng.jpeg', 
					condition:'Very Good', 
					rate_level: 3, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2019-03-18 00:00:00', 
					name:'Collection of Doraemon', 
					description:'a full set of doraemon in english, heart-warming sweet Japanese science fiction stories, really nice for children to read.',
					},
					

					{category_id:'8',
					address:3,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Books/dorajap.jpeg', 
					condition:'Very Good', 
					rate_level: 3, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2019-05-22 00:00:00', 
					name:'Doraemon original Japanese copies', 
					description:'The book is in Japanese, but you are welcome to borrow it even if you don\'t understand',
					},

					{category_id:'8',
					address:5,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Books/narutostick.jpeg', 
					condition:'Good', 
					rate_level: 3, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2019-05-22 00:00:00', 
					name:'Naruto Sticker book', 
					description:'It is a collection book, I have all the stickers on it, please do not remove any.',
					},

					{category_id:'8',
					address:3,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Books/narutofull.jpeg', 
					condition:'Very Good', 
					rate_level: 5, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2019-05-22 00:00:00', 
					name:'Doraemon original Japanese copies', 
					description:'Complete collection of Naruto, only for those who are true fans.',
					},

					{category_id:'8',
					address:3,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Books/dragon.jpeg', 
					condition:'Good', 
					rate_level: 3, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2019-04-12 00:00:00', 
					name:'Dragon Ball series', 
					description:'Full set of dragonball comics.',
					},

					{category_id:'9',
					address:3,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Books/viet.jpeg', 
					condition:'Good', 
					rate_level: 3, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2019-06-30 00:00:00', 
					name:'Vietnamese recipe book', 
					description:'It has all your favorite Vietnamese dishes inside, pho, barbeque pork rice...anything you name it.',
					},

					{category_id:'10',
					address:1,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/MusicMovie/atlan.jpeg', 
					condition:'Good', 
					rate_level: 3, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2019-06-30 00:00:00', 
					name:'Atlantis blu-ray movie', 
					description:'Tells a great adventure story, I recommend it for teenagers.',
					brand:'Disney',
					},

					{category_id:'10',
					address:5,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/MusicMovie/captain.jpeg', 
					condition:'Very Good', 
					rate_level: 4, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2019-04-30 00:00:00', 
					name:'Captain America Blu-ray', 
					description:'Captain America',
					brand:'Marvel',
					},

					{category_id:'10',
					address:5,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/MusicMovie/jonah.jpeg', 
					condition:'Good', 
					rate_level: 3, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2019-06-30 00:00:00', 
					name:'Jonah movie', 
					description:'A very old movie, comes in blu-ray.',
					},

					{category_id:'11',
					address:5,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/MusicMovie/12strong.jpeg', 
					condition:'Brand New', 
					rate_level: 3, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2019-01-05 00:00:00', 
					name:'12 Strong movie digital', 
					description:'Recently released movie, action war drama. It is in my USB, you will need to pick it up.',
					},

					{category_id:'13',
					address:5,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Electronics/printer.jpeg', 
					condition:'Like New', 
					rate_level: 2, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2028-01-01 00:00:00', 
					name:'Canon printer',
					brand:'Canon' ,
					description:'A Canon printer I recently bought. I will not hand it to you, but if you are in my neighborhood and want to print something, I can do it for you with this.',
					},

					{category_id:'13',
					address:5,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Electronics/pprinter.jpeg', 
					condition:'Like New', 
					rate_level: 5, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2028-06-01 00:00:00', 
					name:'Epson portable printer', 
					brand:'Epson',
					description:'It is a portable printer, easy to carry around. It is taking too much space of my table, lending it out till I move',
					},

					{category_id:'13',
					address:5,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Electronics/scanner.jpeg', 
					condition:'Brand New', 
					rate_level: 1, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2028-06-01 00:00:00', 
					name:'FastFoto FF640 scanner', 
					brand:'Epson',
					description:'Scanner in my room, come and use it if you want.',
					},

					{category_id:'14',
					address:5,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Electronics/gtx1080.jpeg', 
					condition:'Like New', 
					rate_level: 1, 
					time_start:'2018-01-06 00:00:00', 
					time_end: '2028-01-20 00:00:00', 
					name:'GTX1080 card', 
					brand:'ASUS',
					description:'I will not hand the card to you, but you can use a server to do computation once I accept your request.',
					},

					{category_id:'14',
					address:5,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Electronics/keyboard.jpeg', 
					condition:'Like New', 
					rate_level: 5, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2028-06-01 00:00:00', 
					name:'Majestouch keyboard black switch', 
					brand:'Filco',
					description:'Black switch filco keyboard, haven\'t used it since I had a new Razer keyboard.',
					},

					{category_id:'14',
					address:5,
					owner:'raymondfzy@gmail.com', 
					photo_url:'/assets/img/Electronics/headset.jpeg', 
					condition:'Defective', 
					rate_level: 1, 
					time_start:'2018-12-01 00:00:00', 
					time_end: '2028-06-01 00:00:00', 
					name:'Sony wireless headset (broken)', 
					brand:'Sony',
					description:'It is broken but still usable. I bought a new one, so whoever wants it just take it. Works totally well if you tape it together',
					},
				])
                    #    {category_id:'4',owner:'raymondfzy@gmail.com', photo_url:'/assets/img/imgplaceholder.gif', condition:'Like New', rate_level: 5, time_start:'2018-12-12 00:00:00', time_end: '2018-12-26 13:23:04', name:'Introduction to algorithm', description:'used textbook', brand:'brand2'},
                    #    {category_id:'4',owner:'createduser@gmail.com', photo_url:'/assets/img/imgplaceholder.gif', condition:'Brand New',time_start:'2018-11-12 00:00:00', time_end: '2018-12-25 13:23:04', name:'Quantum Mechanics', description:'slaknfw93*(&%^&@#)(Unkasbfjweo',brand:'Sciencene'},
					#    {category_id:'3',owner:'geling.li@mail.utoronto.ca', photo_url:'/assets/img/imgplaceholder.gif', condition:'Like New', time_start:'2018-11-12 00:00:00', time_end: '2018-12-25 13:23:04', name:'Learn C++ in 21 Days', description:'This dude is lazy and did not leave anything here', brand:'XinHua'},
					#    {category_id:'3',owner:'raymondfzy@gmail.com', photo_url:'/assets/img/imgplaceholder.gif', condition:'Very Good', rate_level: 3, time_start:'2018-11-16 00:00:00', time_end: '2018-12-23 13:23:04', name:'King Lear',description:'see the picture', brand:'brand3'},
                    # {category_id:'3',owner:'raymondfzy@gmail.com', photo_url:'/assets/img/imgplaceholder.gif', status:'lent', condition:'Good', rate_level: 2, time_start:'2018-11-08 00:00:00', time_end: '2019-01-25 13:23:04', name:'Don Quixote', description:'This dude is lazy and did not leave anything here', brand:'brand4'},
					# {category_id:'3',owner:'suspendeduser@gmail.com', photo_url:'/assets/img/imgplaceholder.gif', status:'lent', condition:'Brand New', time_start:'2018-11-12 00:00:00', time_end: '2018-12-25 13:23:04', name:'Frankenstein', description:'frank', brand:'brand3'},
					# {category_id:'2',owner:'raymondfzy@gmail.com', photo_url:'/assets/img/imgplaceholder.gif',status:'lent', condition:'Adequate', time_start:'2018-11-12 00:00:00', time_end: '2018-12-25 13:23:04', name:'Halo 7',description:'This dude is lazy and did not leave anything here',brand:'brand1'},
                    # {category_id:'2',owner:'raymondfzy@gmail.com', photo_url:'/assets/img/imgplaceholder.gif', condition:'Defective', time_start:'2018-11-12 00:00:00', time_end: '2018-12-25 13:23:04', name:'Resident Evil',description:'This dude is lazy and did not leave anything here',brand:'brand1'},
                    # {category_id:'2',owner:'banneduser@gmail.com', photo_url:'/assets/img/imgplaceholder.gif', condition:'Brand New', time_start:'2018-11-12 00:00:00', time_end: '2018-12-25 13:23:04', name:'Monster Hunter', description:'3ds version', brand:'Kapkom'},
                    # {category_id:'2',owner:'geling.li@mail.utoronto.ca', photo_url:'/assets/img/imgplaceholder.gif', condition:'Good', time_start:'2018-11-12 00:00:00', time_end: '2018-12-25 13:23:04', name:'Tomb Raider', description:'The best one of the series', brand:'3DM Private Games'}
                    

requests = Request.create([
		{item_id:1, borrower:'raymondfzy@gmail.com', time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:2, borrower:'raymondfzy@gmail.com', time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:3, borrower:'raymondfzy@gmail.com', time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:4, borrower:'raymondfzy@gmail.com', time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:5, borrower:'raymondfzy@gmail.com', time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:6, borrower:'raymondfzy@gmail.com', time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:1, borrower:'geling.li@mail.utoronto.ca', time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		
		{item_id:1, borrower:'raymondfzy@gmail.com', time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:2, borrower:'raymondfzy@gmail.com', time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:3, borrower:'raymondfzy@gmail.com', time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},

		{item_id:7, borrower:'raymondfzy@gmail.com', time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:8, borrower:'raymondfzy@gmail.com', time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:9, borrower:'raymondfzy@gmail.com', time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:7, borrower:'geling.li@mail.utoronto.ca', time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:8, borrower:'geling.li@mail.utoronto.ca', time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'},
		{item_id:9, borrower:'geling.li@mail.utoronto.ca', time_start:'2018-09-25 00:00:00', time_end:'2018-11-22 00:00:00'}
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
