SET ECHO ON
SPOOL "C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Week 8\Project\Populate\TimberPopulate.txt"

DELETE TB_Order_Item;
DELETE TB_Supplier;
DELETE TB_Product_Manifest;
DELETE TB_Customer_Order;
DELETE TB_Product_Review;
DELETE TB_Customer;
DELETE TB_Product;
DELETE TB_Category;
DELETE TB_Tax;

INSERT INTO TB_Tax (Tax_Prov,Tax_Rate ) VALUES ('AB',5);
INSERT INTO TB_Tax (Tax_Prov,Tax_Rate ) VALUES ('BC',12);
INSERT INTO TB_Tax (Tax_Prov,Tax_Rate ) VALUES ('MB',12);
INSERT INTO TB_Tax (Tax_Prov,Tax_Rate ) VALUES ('NB',15);
INSERT INTO TB_Tax (Tax_Prov,Tax_Rate ) VALUES ('NL',15);
INSERT INTO TB_Tax (Tax_Prov,Tax_Rate ) VALUES ('NT',5);
INSERT INTO TB_Tax (Tax_Prov,Tax_Rate ) VALUES ('NS',15);
INSERT INTO TB_Tax (Tax_Prov,Tax_Rate ) VALUES ('NU',5);
INSERT INTO TB_Tax (Tax_Prov,Tax_Rate ) VALUES ('ON',13);
INSERT INTO TB_Tax (Tax_Prov,Tax_Rate ) VALUES ('PE',15);
INSERT INTO TB_Tax (Tax_Prov,Tax_Rate ) VALUES ('QC',15);
INSERT INTO TB_Tax (Tax_Prov,Tax_Rate ) VALUES ('SK',11);
INSERT INTO TB_Tax (Tax_Prov,Tax_Rate ) VALUES ('YT',5);


INSERT INTO TB_Category (category_num, category_name, parent_CatNum) VALUES ('1',	            'Books'	                     ,           '0');
INSERT INTO TB_Category (category_num, category_name, parent_CatNum) VALUES ('2',	            'Video Games and Prime Gaming'	,            '0');
INSERT INTO TB_Category (category_num, category_name, parent_CatNum) VALUES ('3',	            'Music, Movies and TV Shows'	  ,          '0');
INSERT INTO TB_Category (category_num, category_name, parent_CatNum) VALUES ('4',	            'Books in French'	           ,             '1');
INSERT INTO TB_Category (category_num, category_name, parent_CatNum) VALUES ('5',	            'PC Gaming'	                 ,           '2');
INSERT INTO TB_Category (category_num, category_name, parent_CatNum) VALUES ('6',	            'Canadian Music'	            ,            '3');


INSERT INTO TB_Product (product_number,	  title	,   product_description,	price,	weight_kg,	tax_exempt,	category_num) VALUES ('1',	'Air Fryer - 107 recettes parfaites de l entree au dessert' , 'Allô les kikis !. OK. C est l heure. Tu sens que tu vas craquer. Tu vas l acheter, la fameuse machine qui fait capoter Nicole. Et dont le voisin Marc-André ne cesse de te vanter les mérites. Même le roi des ondes lui réserve des segments de son émission! En fait, c est tellement l heure que tu penses remplacer ta douce moitié par un air fryer tant l appareil semble extraordinaire et miraculeux.. Découvre 107 recettes qui garantissent une multitude de repas sensationnels, cuits en un rien de temps – avec si peu d huile et tout plein d amour. Pain doré en croûte, pelures de pommes de terre farcies, boeuf à l orange, poulet popcorn, morue au beurre, tofu grillé, mille sortes de frites, bagels maison et fondant au chocolat en utilisant seulement un ridicule soupçon d huile d olive ? C est par ici ! Fini les odeurs de friture et les mets trop gras. Cette machine formidable ravit à la fois les gens super soucieux de leur santé et les super gourmands, tout autant que les paresseux et les pressés.. C est l heure. C est vraiment l heure de succomber au air fryer !.','26.95',	0.53,	0,	'4');
INSERT INTO TB_Product (product_number,	  title	,   product_description,	price,	weight_kg,	tax_exempt,	category_num) VALUES ('2',	'Le ti-pou d Amerique - Mieux', 'le comprendre pour mieux	Ah ! Le ti-pou d Amérique. Fascinante créature à la fois adorable et mauditement gossante qui a le don de nous pousser aux limites de notre patience !. Pourquoi Maxime-Henri prend-il 75 heures pour s habiller même si ses vêtements sont prêts à être enfilés ? Pourquoi Simone-Fleur fait-elle une crise au moment d aller dans le bain et en fait-elle une autre pour ne pas en sortir ? Pourquoi Lili-Soleil oublie-t-elle la consigne qu elle comprenait très bien il y a 0,24 seconde ? D où viennent les crises, le refus de partager, les interminables routines prédodo, la découverte de son corps, l impulsivité ou l angoisse de séparation ? Tant de questions…. A l opposé des guides populaires qui donnent les mêmes trucs à tout le monde, ce livre drôle, bienveillant, déculpabilisant, un brin rentre-dedans et formidablement pratique permet de cerner le besoin caché derrière le comportement de son ti-pou. Comment ? En invitant les parents à se poser d abord cette grande question : « Qu est-ce que je vois quand mon enfant fait ça ? » Le ti-pou d Amérique propose une approche dépourvue de jugement qui valide que c est tough en sivouplait la parentalité. Et qui normalise le ressenti du parent même si c est sa responsabilité de comprendre son enfant pour mieux intervenir auprès de lui.. Alors, on met nos idées préconçues à la poubelle et on prend notre enfant par la main, là où il est et non là où il devrait être selon Internet (ou la belle-soeur dont le ti-pou est teeelllement parfait)..',	'24.95',	0.32,	0,	'4');
INSERT INTO TB_Product (product_number,	  title	,   product_description,	price,	weight_kg,	tax_exempt,	category_num) VALUES ('3',	'Hyper Cloud X II - Gaming Headset',	'About this item USB Audio Sound Card with 7.1 Virtual Surround Sound; Sound pressure level: 104dBSPL/mW at 1kHz 53mm Drivers Neodymium Magnets. Durable aluminium frame with expanded headband. Cable Length (imperial) and type: 1m headset cable Noise Cancelling Microphone via Inline Sound Card. Noise cancellation Type: Passive
Echo Cancelling via Inline Sound Card.Ambient noise attenuation:approx. 20 dBa
15-25kKhz Frequency Response. Connection Type: Wired 3.5mm (4-pole CTIA)',	'110.58',	0.3	,0,	'5');
INSERT INTO TB_Product (product_number,	  title	,   product_description,	price,	weight_kg,	tax_exempt,	category_num) VALUES ('4',	'Audeze Penrose  Over-Ear gaming headset',	'Vinyl LP pressing in gatefold jacket. Country superstar Luke Combs   highly anticipated new album, Growin   Up, is available now. Produced by Combs, Chip Matthews and Jonathan Singleton, Growin   Up is Combs   third studio album following 2019  s 3x Platinum What You See is What You Get and his 4x Platinum debut, This One  s For You, and consists of twelve songs including his new single,  The Kind of Love We Make.', 	'355',	0.113,	0,	'5');
INSERT INTO TB_Product (product_number,	  title	,   product_description,	price,	weight_kg,	tax_exempt,	category_num) VALUES ('5',	'Growin Up (Viny)',	'Vinyl LP pressing in gatefold jacket. Country superstar Luke Combs  highly anticipated new album, Growin  Up, is available now. Produced by Combs, Chip Matthews and Jonathan Singleton, Growin  Up is Combs  third studio album following 2019 s 3x Platinum What You See is What You Get and his 4x Platinum debut, This One s For You, and consists of twelve songs including his new single,  The Kind of Love We Make.', 	'37.69',	0.217,	0	,'6');


insert into TB_Customer (customer_number, street_address, city, prov, postal_code, phone_number, email_address, is_TimMem) values (11, '123 Livingston', 'Calgary', 'AB', 'T2X4F3', '403.888.9999', 'this@outlook.com', 0);
insert into TB_Customer (customer_number, street_address, city, prov, postal_code, phone_number, email_address, is_TimMem) values (22, '124 Livingston', 'Calgary', 'AB', 'S5D5T1', '403.888.9999', 'that@outlook.com', 1);
insert into TB_Customer (customer_number, street_address, city, prov, postal_code, phone_number, email_address, is_TimMem) values (33, '125 Livingston', 'Calgary', 'AB', 'T2Y6D2', '403.777.8888', 'thisthat@gmail.com', 0);
insert into TB_Customer (customer_number, street_address, city, prov, postal_code, phone_number, email_address, is_TimMem) values (44, '126 Livingston', 'Calgary', 'AB', 'T3T3T3', '403.444.5555', 'hellothere@hotmail.com', 1);
insert into TB_Customer (customer_number, street_address, city, prov, postal_code, phone_number, email_address, is_TimMem) values (55, '127 Livingston', 'Calgary', 'AB', 'T2D4S3', '403.111.2222', 'yellothere@gmail.com', 0);

insert into TB_Product_Review (review_number, product_number, rating, comments, review_date, price, product_weight, tax_exempt) values (111, 4, 1, NULL, NULL, 355, 0.113, 0);
insert into TB_Product_Review (review_number, product_number, rating, comments, review_date, price, product_weight, tax_exempt) values (222, 2, 4.8, 'Ce livre est arrivé comme une bouée de sauvetage dans nos vies. Pas toujours facile d être parent d un jeune enfant, mais on se pose souvent la question "est-ce que j en fais assez ? comment est-ce que je peux être meilleure papa / maman ?". Il y a 1 millions de livre de "parenting" disponible, mais c est le premier qui est sincèrement intéressant, et adresse des questions difficile dans un ton léger et humoristique. Ce livre ne prétend pas avoir LA réponse à toutes les solutions, mais c est le seul qui explique, dans des termes bien vulgarisés, et aussi dans un contexte très humoristique, POURQUOI l enfant agit ainsi et les stades du développement. Si ce livre avait été disponible avant la naissance de mon enfant, je l achèterais et le lirais, et relirais, si c est juste pour mieux comprendre le comportement de l enfant, et me permettre de mieux guider ma petite dans ses émotions et aventures futures. Merci infiniment à l auteure, je le garde sur ma table de chevet et le consulte régulièrement. C est drôle, léger, mais aussi, nous aide à mieux intervenir. Je le recommande fortement à tous les parents de jeunes enfants. Allez l acheter, ici ou bien dans votre librairie proche de chez vous. Droppez tout et allez mettre la main dessus. Vous me remercierez.', '23-Dec-22', 24.95, 0.32, 0);
insert into TB_Product_Review (review_number, product_number, rating, comments, review_date, price, product_weight, tax_exempt) values (333, 1, 4.7, 'livre bien ecrit, recettes tres bonnes', '10-Mar-23', 26.95, 0.53, 0);
insert into TB_Product_Review (review_number, product_number, rating, comments, review_date, price, product_weight, tax_exempt) values (444, 3, 4.5, 'Great headset, only concern would be there is no volume control on the headset itself. To control volume you have to open up the settings menu on the PS5 menu.', '21-Feb-23', 110.58, 0.3, 0);
insert into TB_Product_Review (review_number, product_number, rating, comments, review_date, price, product_weight, tax_exempt) values (555, 5, 4.8, 'Maybe not as good as «  What you see is what you get » but a great album', '14-Feb-23', 37.69, 0.272, 0);

insert into TB_Customer_Order (order_number, customer_number, order_item, order_date, est_deliv_date, ship_amt, amt_tax, ship_prov) values (1111, 11, 1, '16-Mar-22', '16-Mar-23', 10, 5, 'AB'); 
insert into TB_Customer_Order (order_number, customer_number, order_item, order_date, est_deliv_date, ship_amt, amt_tax, ship_prov) values (2222, 22, 2, '16-Mar-22', '16-Mar-23', 10, 5, 'AB');
insert into TB_Customer_Order (order_number, customer_number, order_item, order_date, est_deliv_date, ship_amt, amt_tax, ship_prov) values (3333, 33, 3, '16-Mar-22', '16-Mar-23', 10, 5, 'AB');
insert into TB_Customer_Order (order_number, customer_number, order_item, order_date, est_deliv_date, ship_amt, amt_tax, ship_prov) values (4444, 44, 4, '16-Mar-22', '16-Mar-23', 10, 5, 'AB'); 
insert into TB_Customer_Order (order_number, customer_number, order_item, order_date, est_deliv_date, ship_amt, amt_tax, ship_prov) values (5555, 55, 5, '16-Mar-22', '16-Mar-23', 10, 5, 'AB'); 

insert into TB_Supplier (supplier_number, supplier_name, email, supplier_city, supplier_prov) values (11111, 'Guy Saint-Jean', 'guy@gmail.com', 'Quebec City', 'QC');
insert into TB_Supplier (supplier_number, supplier_name, email, supplier_city, supplier_prov) values (22222, 'Guy Saint-Jean 2', 'guy@gmail.com', 'Quebec City', 'QC');
insert into TB_Supplier (supplier_number, supplier_name, email, supplier_city, supplier_prov) values (33333, 'HyperX', 'hyper@gmail.com', 'Saskatchewn', 'SK');
insert into TB_Supplier (supplier_number, supplier_name, email, supplier_city, supplier_prov) values (44444, 'Audeze', 'Audeze@gmail.com', 'Mississauga', 'ON' );
insert into TB_Supplier (supplier_number, supplier_name, email, supplier_city, supplier_prov) values (55555, 'Amazon', 'Amazon@gmail.com', 'Etobicoke', 'ON');

insert into TB_Product_Manifest (Supplier_number, product_number, quantity, est_days) values (11111, 1, 1000, 11);
insert into TB_Product_Manifest (Supplier_number, product_number, quantity, est_days) values (22222, 2, 2000, 12);
insert into TB_Product_Manifest (Supplier_number, product_number, quantity, est_days) values (33333, 3, 3000, 13);
insert into TB_Product_Manifest (Supplier_number, product_number, quantity, est_days) values (44444, 4, 4000, 14);
insert into TB_Product_Manifest (Supplier_number, product_number, quantity, est_days) values (55555, 5, 5000, 15);

insert into TB_Order_Item (order_number, product_number) values (1111, 1);
insert into TB_Order_Item (order_number, product_number) values (2222, 2);
insert into TB_Order_Item (order_number, product_number) values (3333, 3);
insert into TB_Order_Item (order_number, product_number) values (4444, 4);
insert into TB_Order_Item (order_number, product_number) values (5555, 5);