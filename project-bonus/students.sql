
create table fields(field varchar(50), primary key (field));

insert into fields (field) values ('Theory');
insert into fields (field) values ('Artificial Intelligence');
insert into fields (field) values ('Networks');
insert into fields (field) values ('Databases');
insert into fields (field) values ('Security');


create table student_type (type varchar(20), primary key (type));

insert into student_type (type) values ('Freshman');
insert into student_type (type) values ('Sophomore');
insert into student_type (type) values ('Junior');
insert into student_type (type) values ('Senior');
insert into student_type (type) values ('Graduate Student');


create table advisors  (
	id SERIAL,
	name VARCHAR(20),
	field VARCHAR(50),
	experience INT,
    Primary key (id),
    foreign key (field) references fields (field)
);


create table students (
	id SERIAL,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(50),
	student_type varchar(20),
	advisor_id INT,
    primary key (id),
    foreign key (student_type) references student_type (type),
	foreign key (advisor_id) references advisors (id)
);

create table needs (
	id INT,
	field VARCHAR(50),
	primary key (id,field),
	foreign key (id) references students (id),
	foreign key (field) references fields (field)
);

create table available (
	id INT,
	field VARCHAR(50),
	primary key (id,field),
	foreign key (id) references students (id),
	foreign key (field) references fields (field)
);

insert into advisors  (name, field, experience) values ('Smith', 'Artificial Intelligence', 4);
insert into advisors  (name, field, experience) values ('Johnson', 'Theory', 8);
insert into advisors  (name, field, experience) values ('Williams', 'Networks', 5);
insert into advisors  (name, field, experience) values ('Jones', 'Theory', 2);
insert into advisors  (name, field, experience) values ('Brown', 'Databases', 3);
insert into advisors  (name, field, experience) values ('Davis', 'Databases', 8);
insert into advisors  (name, field, experience) values ('Miller', 'Security', 4);
insert into advisors  (name, field, experience) values ('Wilson', 'Artificial Intelligence', 5);
insert into advisors  (name, field, experience) values ('Moore', 'Security', 6);
insert into advisors  (name, field, experience) values ('Taylor', 'Networks', 9);
insert into advisors  (name, field, experience) values ('Anderson', 'Theory', 5);
insert into advisors  (name, field, experience) values ('Thomas', 'Security', 1);
insert into advisors  (name, field, experience) values ('Jackson', 'Databases', 6);
insert into advisors  (name, field, experience) values ('White', 'Security', 7);
insert into advisors  (name, field, experience) values ('Harris', 'Artificial Intelligence', 4);
insert into advisors  (name, field, experience) values ('Martin', 'Networks', 8);
insert into advisors  (name, field, experience) values ('Thompson', 'Networks', 3);
insert into advisors  (name, field, experience) values ('Garcia', 'Security', 9);
insert into advisors  (name, field, experience) values ('Martinez', 'Networks', 4);
insert into advisors  (name, field, experience) values ('Robinson', 'Databases', 4);
insert into advisors  (name, field, experience) values ('Clark', 'Networks', 7);
insert into advisors  (name, field, experience) values ('Rodriguez', 'Security', 7);
insert into advisors  (name, field, experience) values ('Lewis', 'Theory', 10);
insert into advisors  (name, field, experience) values ('Lee', 'Security', 10);
insert into advisors  (name, field, experience) values ('Walker', 'Networks', 1);
insert into advisors  (name, field, experience) values ('Hall', 'Databases', 8);
insert into advisors  (name, field, experience) values ('Allen', 'Artificial Intelligence', 1);
insert into advisors  (name, field, experience) values ('Young', 'Databases', 6);
insert into advisors  (name, field, experience) values ('Hernandez', 'Theory', 4);
insert into advisors  (name, field, experience) values ('King', 'Artificial Intelligence', 4);
insert into advisors  (name, field, experience) values ('Wright', 'Security', 8);
insert into advisors  (name, field, experience) values ('Lopez', 'Networks', 5);
insert into advisors  (name, field, experience) values ('Hill', 'Security', 5);
insert into advisors  (name, field, experience) values ('Scott', 'Security', 7);
insert into advisors  (name, field, experience) values ('Green', 'Databases', 9);
insert into advisors  (name, field, experience) values ('Adams', 'Networks', 9);
insert into advisors  (name, field, experience) values ('Baker', 'Databases', 7);
insert into advisors  (name, field, experience) values ('Gonzalez', 'Networks', 4);
insert into advisors  (name, field, experience) values ('Nelson', 'Artificial Intelligence', 2);
insert into advisors  (name, field, experience) values ('Carter', 'Networks', 7);
insert into advisors  (name, field, experience) values ('Mitchell', 'Theory', 9);
insert into advisors  (name, field, experience) values ('Perez', 'Security', 3);
insert into advisors  (name, field, experience) values ('Roberts', 'Security', 7);
insert into advisors  (name, field, experience) values ('Turner', 'Databases', 2);
insert into advisors  (name, field, experience) values ('Phillips', 'Networks', 7);
insert into advisors  (name, field, experience) values ('Campbell', 'Artificial Intelligence', 7);
insert into advisors  (name, field, experience) values ('Parker', 'Databases', 6);
insert into advisors  (name, field, experience) values ('Evans', 'Artificial Intelligence', 2);
insert into advisors  (name, field, experience) values ('Edwards', 'Artificial Intelligence', 7);
insert into advisors  (name, field, experience) values ('Collins', 'Theory', 3);
insert into advisors  (name, field, experience) values ('Stewart', 'Databases', 7);
insert into advisors  (name, field, experience) values ('Sanchez', 'Security', 6);
insert into advisors  (name, field, experience) values ('Morris', 'Networks', 8);
insert into advisors  (name, field, experience) values ('Rogers', 'Networks', 6);
insert into advisors  (name, field, experience) values ('Reed', 'Theory', 4);
insert into advisors  (name, field, experience) values ('Cook', 'Databases', 8);
insert into advisors  (name, field, experience) values ('Morgan', 'Security', 9);
insert into advisors  (name, field, experience) values ('Bell', 'Networks', 6);
insert into advisors  (name, field, experience) values ('Murphy', 'Networks', 6);
insert into advisors  (name, field, experience) values ('Bailey', 'Theory', 10);
insert into advisors  (name, field, experience) values ('Rivera', 'Theory', 7);
insert into advisors  (name, field, experience) values ('Cooper', 'Security', 10);
insert into advisors  (name, field, experience) values ('Richardson', 'Networks', 1);
insert into advisors  (name, field, experience) values ('Cox', 'Theory', 1);
insert into advisors  (name, field, experience) values ('Howard', 'Theory', 7);
insert into advisors  (name, field, experience) values ('Ward', 'Security', 7);
insert into advisors  (name, field, experience) values ('Torres', 'Databases', 9);
insert into advisors  (name, field, experience) values ('Peterson', 'Networks', 2);
insert into advisors  (name, field, experience) values ('Gray', 'Databases', 8);
insert into advisors  (name, field, experience) values ('Ramirez', 'Databases', 1);
insert into advisors  (name, field, experience) values ('James', 'Security', 6);
insert into advisors  (name, field, experience) values ('Watson', 'Databases', 5);
insert into advisors  (name, field, experience) values ('Brooks', 'Security', 10);
insert into advisors  (name, field, experience) values ('Kelly', 'Theory', 2);
insert into advisors  (name, field, experience) values ('Sanders', 'Theory', 2);
insert into advisors  (name, field, experience) values ('Price', 'Security', 4);
insert into advisors  (name, field, experience) values ('Bennett', 'Theory', 8);
insert into advisors  (name, field, experience) values ('Wood', 'Security', 4);
insert into advisors  (name, field, experience) values ('Barnes', 'Databases', 8);
insert into advisors  (name, field, experience) values ('Ross', 'Theory', 8);
insert into advisors  (name, field, experience) values ('Henderson', 'Databases', 4);
insert into advisors  (name, field, experience) values ('Coleman', 'Networks', 3);
insert into advisors  (name, field, experience) values ('Jenkins', 'Artificial Intelligence', 4);
insert into advisors  (name, field, experience) values ('Perry', 'Theory', 1);
insert into advisors  (name, field, experience) values ('Powell', 'Security', 1);
insert into advisors  (name, field, experience) values ('Long', 'Artificial Intelligence', 5);
insert into advisors  (name, field, experience) values ('Patterson', 'Theory', 2);
insert into advisors  (name, field, experience) values ('Hughes', 'Security', 3);
insert into advisors  (name, field, experience) values ('Flores', 'Networks', 9);
insert into advisors  (name, field, experience) values ('Washington', 'Databases', 1);
insert into advisors  (name, field, experience) values ('Butler', 'Databases', 2);
insert into advisors  (name, field, experience) values ('Simmons', 'Theory', 4);
insert into advisors  (name, field, experience) values ('Foster', 'Security', 2);
insert into advisors  (name, field, experience) values ('Gonzales', 'Networks', 4);
insert into advisors  (name, field, experience) values ('Bryant', 'Artificial Intelligence', 10);
insert into advisors  (name, field, experience) values ('Alexander', 'Artificial Intelligence', 3);
insert into advisors  (name, field, experience) values ('Russell', 'Artificial Intelligence', 6);
insert into advisors  (name, field, experience) values ('Griffin', 'Theory', 2);
insert into advisors  (name, field, experience) values ('Diaz', 'Security', 5);
insert into advisors  (name, field, experience) values ('Hayes', 'Artificial Intelligence', 6);



insert into students (first_name, last_name, email, student_type, advisor_id) values ('Ric', 'Vescovini', 'ric.vescovini@umd.edu', 'Freshman', 31);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Jacquelyn', 'Dukes', 'Jacquelyn.dukes@umd.edu', 'Sophomore', 49);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Dorree', 'Grimmett', 'dorree.grimmett@umd.edu', 'Freshman', 26);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Burk', 'Aldren', 'burk.aldren@umd.edu', 'Junior', 89);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Lilia', 'Heyns', 'lilia.heyns@umd.edu', 'Sophomore', 86);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Emmott', 'Grinikhinov', 'emmott.grinikhinov@umd.edu', 'Senior', 4);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Danya', 'Brisland', 'danya.brisland@umd.edu', 'Freshman', 78);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Archambault', 'Braune', 'archambault.braune@umd.edu', 'Senior', 9);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Bryana', 'Marran', 'bryana.marran@umd.edu', 'Senior', 99);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Lockwood', 'Trill', 'lockwood.trill@umd.edu', 'Graduate Student', 91);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Barbe', 'Udale', 'barbe.udale@umd.edu', 'Sophomore', 55);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Patrizius', 'Ashlee', 'patrizius.ashlee@umd.edu', 'Graduate Student', 40);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Donavon', 'Tolland', 'donavon.tolland@umd.edu', 'Graduate Student', 58);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Morten', 'Ricardin', 'morten.ricardin@umd.edu', 'Sophomore', 32);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Vania', 'Gummie', 'vania.gumie@umd.edu', 'Senior', 47);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Velvet', 'Pesic', 'velvet.pesic@umd.edu', 'Sophomore', 100);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Tally', 'Oleszkiewicz', 'tally.oleszkewicz@umd.edu', 'Graduate Student', 92);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Sherwood', 'Matushenko', 'sherwood.matushenko@umd.edu', 'Graduate Student', 85);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Alix', 'Luparti', 'alix.luparti@umd.edu', 'Sophomore', 1);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Blakelee', 'D''Avaux', 'blakelee.davaux@umd.edu', 'Junior', 51);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Helyn', 'Baldree', 'helyn.baldree@umd.edu', 'Junior', 9);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Carol', 'Lowndsborough', 'carol.lowndsbrough@umd.edu', 'Freshman', 32);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Cory', 'Moberley', 'cory.moberley@umd.edu', 'Junior', 64);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Ezequiel', 'Mattis', 'exequiel.mattis@umd.edu', 'Sophomore', 13);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Kane', 'Davenhill', 'kane.davenhill@umd.edu', 'Senior', 83);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Emmott', 'Frances', 'emmott.frances@umd.edu', 'Senior', 27);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Nicolas', 'Philippsohn', 'nicolas.philippsohn@umd.edu', 'Senior', 85);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Antonella', 'Woolbrook', 'antonella.woolbrook@umd.edu', 'Sophomore', 84);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Enoch', 'Kasper', 'enoch.kasper@umd.edu', 'Senior', 86);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Puff', 'Bullingham', 'puff.bullingham@umd.edu', 'Junior', 39);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Filmer', 'Thorald', 'filmer.thorald@umd.edu', 'Sophomore', 51);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Florance', 'Godsal', 'florance.godsal@umd.edu', 'Sophomore', 51);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Melicent', 'Bearham', 'melicent.bearham@umd.edu', 'Senior', 14);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Romy', 'Spleving', 'romy.spleving@umd.edu', 'Sophomore', 3);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Connor', 'Birks', 'connor.birks@umd.edu', 'Sophomore', 3);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Lilias', 'Lockney', 'lilias.lockney@umd.edu', 'Senior', 4);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Sophie', 'Ducker', 'sophie.ducker@umd.edu', 'Senior', 16);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Lila', 'Whitsey', 'lila.whitsey@umd.edu', 'Sophomore', 92);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Jason', 'Kunzler', 'jason.kunzler@umd.edu', 'Sophomore', 3);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Nicola', 'Zorn', 'nicola.zorn@umd.edu', 'Senior', 83);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Gabrila', 'Siddaley', 'gabrila.siddaley@umd.edu', 'Junior', 12);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Miquela', 'Moule', 'miquela.moule@umd.edu', 'Sophomore', 40);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Calypso', 'Van Der Hoog', 'calypso.hoog@umd.edu', 'Graduate Student', 53);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Trevar', 'Daish', 'trevar.daish@umd.edu', 'Senior', 72);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Shena', 'Grigoli', 'shena.grigoli@umd.edu', 'Senior', 100);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Teddy', 'Garrettson', 'teddy.garrettson@umd.edu', 'Graduate Student', 88);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Trumaine', 'Polino', 'trumaine.polino@umd.edu', 'Freshman', 75);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Inglebert', 'Pohls', 'inglebert.pohls@umd.edu', 'Senior', 81);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Felita', 'Blastock', 'felita.blastock@umd.edu', 'Senior', 80);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Tamqrah', 'Hartop', 'tamqrah.hartop@umd.edu', 'Senior', 63);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Yorke', 'Cobby', 'yorke.cobby@umd.edu', 'Freshman', 81);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Quintus', 'Kik', 'quintus.kik@umd.edu', 'Senior', 82);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Oriana', 'Kunzel', 'oriana.kunzel@umd.edu', 'Junior', 1);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Cordie', 'Jeanel', 'cordie.jeanel@umd.edu', 'Senior', 71);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Murray', 'Clipston', 'murray.clipston@umd.edu', 'Senior', 35);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Cozmo', 'Preskett', 'cozmo.preskett@umd.edu', 'Sophomore', 28);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Dave', 'Foltin', 'dave.foltin@umd.edu', 'Sophomore', 1);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Susie', 'Bills', 'susie.bills@umd.edu', 'Senior', 64);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Benny', 'Schober', 'benny.schober@umd.edu', 'Junior', 99);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Lesly', 'Phizacklea', 'lesly.phizacklea@umd.edu', 'Sophomore', 59);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Dacia', 'Normanvill', 'dacia.normanvill@umd.edu', 'Freshman', 67);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Quincey', 'Applin', 'quincey.applin@umd.edu', 'Graduate Student', 19);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Rene', 'Lansdale', 'rene.lansdale@umd.edu', 'Junior', 36);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Constantin', 'Adamoli', 'constantin.admoli@umd.edu', 'Sophomore', 90);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Nathanial', 'Lindmark', 'nathanial.lindmark@umd.edu', 'Senior', 29);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Chalmers', 'Gamlen', 'chalmer.gamlem@umd.edu', 'Graduate Student', 58);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Sybyl', 'Grutchfield', 'sybyl.grutchfield@umd.edu', 'Senior', 28);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Carmelita', 'King', 'carmelita.king@umd.edu', 'Senior', 45);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Gayel', 'Fetters', 'gayel.fetters@umd.edu', 'Junior', 79);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Dorette', 'McMoyer', 'dorette.mcmoyer@umd.edu', 'Sophomore', 28);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Gerald', 'Hildred', 'gerald.hilderd@umd.edu', 'Sophomore', 40);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Norean', 'Paolino', 'norean.paolino@umd.edu', 'Junior', 8);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Tally', 'Samways', 'tally.samays@umd.edu', 'Graduate Student', 88);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Rickard', 'Disbrow', 'richard.disbrow@umd.edu', 'Graduate Student', 98);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Yancy', 'Burston', 'yancy.burston@umd.edu', 'Freshman', 53);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Krishnah', 'Szymoni', 'krishnah.szymoni@umd.edu', 'Junior', 93);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Beatrisa', 'Cocking', 'beatrisa.cocking@umd.edu', 'Senior', 60);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Farrel', 'Billborough', 'farrel.billborough@umd.edu', 'Junior', 67);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Alexander', 'Rennox', 'alexander.rennox@umd.edu', 'Senior', 14);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Glenda', 'Polet', 'glenda.polet@umd.edu', 'Freshman', 24);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Felicle', 'McMonnies', 'felicle.mcmonnies@umd.edu', 'Senior', 21);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Ddene', 'Murrell', 'ddene.murrell@umd.edu', 'Senior', 100);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Heall', 'Jerrolt', 'heall.jerrolt@umd.edu', 'Senior', 30);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Emmit', 'Whotton', 'emmit.whotton@umd.edu', 'Sophomore', 6);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Portia', 'Fishly', 'potia.fishly@umd.edu', 'Junior', 42);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Jaclyn', 'Dodle', 'jaclyn.dodle@umd.edu', 'Senior', 75);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Cinnamon', 'Ramsay', 'cinnamon.ramsay@umd.edu', 'Senior', 94);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Andrew', 'McHardy', 'andrew.mchary@umd.edu', 'Freshman', 44);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Edwina', 'Teasdale-Markie', 'edwina.markie@umd.edu', 'Freshman', 5);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Mufinella', 'Laite', 'mufinella.laite@umd.edu', 'Graduate Student', 58);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Tobe', 'Stratiff', 'tobe.stratiff@umd.edu', 'Sophomore', 20);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Evania', 'Keward', 'evanie.keward@umd.edu', 'Junior', 19);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Melinde', 'Slograve', 'melinde.slograve@umd.edu', 'Freshman', 90);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Courtnay', 'Brundrett', 'courtnay.brundrett@umd.edu', 'Junior', 67);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Cly', 'Jindrich', 'cly.jindrich@umd.edu', 'Sophomore', 68);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Viv', 'Bridgwood', 'viv.bridgwood@umd.edu', 'Senior', 54);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Erena', 'Urpeth', 'erena.urpeth@umd.edu', 'Graduate Student', 92);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Shaughn', 'Martinolli', 'shaughn.martinolli@umd.edu', 'Sophomore', 6);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Margaretta', 'Northam', 'margaretta.northam@umd.edu', 'Sophomore', 96);
insert into students (first_name, last_name, email, student_type, advisor_id) values ('Burr', 'Kadwallider', 'burr.kadwallider@umd.edu', 'Senior', 94);

insert into needs (id, field) values (20, 'Networks');
insert into needs (id, field) values (41, 'Theory');
insert into needs (id, field) values (96, 'Databases');
insert into needs (id, field) values (6, 'Theory');
insert into needs (id, field) values (89, 'Theory');
insert into needs (id, field) values (23, 'Networks');
insert into needs (id, field) values (32, 'Security');
insert into needs (id, field) values (65, 'Databases');
insert into needs (id, field) values (86, 'Networks');
insert into needs (id, field) values (10, 'Security');
insert into needs (id, field) values (31, 'Networks');
insert into needs (id, field) values (3, 'Theory');
insert into needs (id, field) values (91, 'Theory');
insert into needs (id, field) values (59, 'Networks');
insert into needs (id, field) values (12, 'Networks');
insert into needs (id, field) values (85, 'Theory');
insert into needs (id, field) values (39, 'Theory');
insert into needs (id, field) values (45, 'Databases');
insert into needs (id, field) values (14, 'Theory');
insert into needs (id, field) values (88, 'Databases');
insert into needs (id, field) values (18, 'Theory');
insert into needs (id, field) values (5, 'Artificial Intelligence');
insert into needs (id, field) values (12, 'Security');
insert into needs (id, field) values (49, 'Databases');
insert into needs (id, field) values (9, 'Artificial Intelligence');
insert into needs (id, field) values (29, 'Databases');
insert into needs (id, field) values (74, 'Security');
insert into needs (id, field) values (64, 'Networks');
insert into needs (id, field) values (7, 'Artificial Intelligence');
insert into needs (id, field) values (100, 'Networks');
insert into needs (id, field) values (61, 'Networks');
insert into needs (id, field) values (27, 'Databases');
insert into needs (id, field) values (39, 'Artificial Intelligence');
insert into needs (id, field) values (19, 'Artificial Intelligence');
insert into needs (id, field) values (29, 'Theory');
insert into needs (id, field) values (36, 'Security');
insert into needs (id, field) values (20, 'Artificial Intelligence');
insert into needs (id, field) values (91, 'Security');
insert into needs (id, field) values (93, 'Networks');
insert into needs (id, field) values (56, 'Artificial Intelligence');
insert into needs (id, field) values (31, 'Artificial Intelligence');
insert into needs (id, field) values (59, 'Artificial Intelligence');
insert into needs (id, field) values (69, 'Artificial Intelligence');
insert into needs (id, field) values (73, 'Artificial Intelligence');
insert into needs (id, field) values (69, 'Networks');
insert into needs (id, field) values (17, 'Theory');
insert into needs (id, field) values (57, 'Security');
insert into needs (id, field) values (91, 'Databases');

insert into available (id, field) values (37, 'Theory');
insert into available (id, field) values (27, 'Theory');
insert into available (id, field) values (90, 'Theory');
insert into available (id, field) values (50, 'Theory');
insert into available (id, field) values (59, 'Networks');
insert into available (id, field) values (24, 'Artificial Intelligence');
insert into available (id, field) values (75, 'Theory');
insert into available (id, field) values (82, 'Networks');
insert into available (id, field) values (14, 'Databases');
insert into available (id, field) values (84, 'Theory');
insert into available (id, field) values (53, 'Artificial Intelligence');
insert into available (id, field) values (3, 'Theory');
insert into available (id, field) values (85, 'Artificial Intelligence');
insert into available (id, field) values (86, 'Theory');
insert into available (id, field) values (17, 'Databases');
insert into available (id, field) values (57, 'Databases');
insert into available (id, field) values (9, 'Security');
insert into available (id, field) values (16, 'Databases');
insert into available (id, field) values (27, 'Security');
insert into available (id, field) values (7, 'Artificial Intelligence');
insert into available (id, field) values (36, 'Theory');
insert into available (id, field) values (5, 'Databases');
insert into available (id, field) values (23, 'Databases');
insert into available (id, field) values (50, 'Artificial Intelligence');
insert into available (id, field) values (49, 'Networks');
insert into available (id, field) values (16, 'Theory');
insert into available (id, field) values (32, 'Networks');
insert into available (id, field) values (29, 'Artificial Intelligence');
insert into available (id, field) values (64, 'Databases');
insert into available (id, field) values (96, 'Security');
insert into available (id, field) values (66, 'Artificial Intelligence');
insert into available (id, field) values (60, 'Databases');
insert into available (id, field) values (33, 'Security');
insert into available (id, field) values (89, 'Security');
insert into available (id, field) values (28, 'Theory');
insert into available (id, field) values (58, 'Databases');
insert into available (id, field) values (96, 'Databases');
insert into available (id, field) values (9, 'Artificial Intelligence');
insert into available (id, field) values (27, 'Networks');
insert into available (id, field) values (45, 'Networks');
insert into available (id, field) values (43, 'Security');
insert into available (id, field) values (52, 'Networks');
insert into available (id, field) values (60, 'Theory');
insert into available (id, field) values (54, 'Theory');
insert into available (id, field) values (74, 'Security');
insert into available (id, field) values (38, 'Databases');
insert into available (id, field) values (39, 'Artificial Intelligence');
