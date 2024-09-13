create type Strutturato as enum (
    'Ricercatore', 'Professore Associato', 'Professore Ordinario');

create type LavoroProgetto as enum (
     'Ricerca e Sviluppo', 'Dimostrazione', 'Management', 'Altro'
);

create type LavoroNonProgettuale as enum(
   'Didattica','Ricerca','Missione','Incontro Dipartimentale','Incontro
Accademico','Altro'
);



create type CausaAssenza as enum (
    'Chiusura Universitaria', 'Maternita', 'Malattia'
);
create domain PoslInteger as INTEGER
    default 0
    check(value >= 0);

create domain StringaM as varchar(100);

create domain NumeroOre as INTEGER
    default 0
check ( value >= 0 and value <= 8);


create domain Denaro as REAL
    default 0
    check(value >= 0);





create TABLE Persona(
    id PoslInteger NOT NULL,
    nome StringaM NOT NULL, 
    cognome StringaM NOT NULL,
    posizione Strutturato NOT NULL, 
    stipendio Denaro NOT NULL,
    primary key(id)
);

create TABLE Progetto(
    id PoslInteger NOT NULL,
    nome StringaM NOT NULL, 
    inizio date NOT NULL,
    fine date NOT NULL,
    budget Denaro NOT NULL,
    primary key (id),
    unique (nome),
        check(inizio < fine)
    );

create TABLE WP(
    progetto PoslInteger NOT NULL,
    id PoslInteger NOT NULL,
    nome StringaM NOT NULL, 
    inizio date NOT NULL,
    fine date NOT NULL,
    primary key(progetto,id),
    foreign key (progetto) references Progetto(id),
    unique (progetto,nome),
        check(inizio < fine)
);

create TABLE AttivitaProgetto(
    progetto PoslInteger NOT NULL,
    id PoslInteger NOT NULL,
    wp PoslInteger NOT NUll,
    Persona PoslInteger NOT NULL,
    tipo LavoroProgetto NOT NULL, 
    giorno date NOT NULL,
    oreDurata NumeroOre NOT NULL,
    primary key(id),
    foreign key (progetto,wp) references WP(progetto,id),
    foreign key(persona) references Persona(id)
);

create TABLE AttivitaNonProgettuale(
    id PoslInteger NOT NULL,
    Persona PoslInteger NOT NULL,
    tipo LavoroNonProgettuale NOT NULL, 
    giorno date NOT NULL,
    oreDurata NumeroOre NOT NULL,
    primary key(id),
    foreign key(persona) references Persona(id)
);

create TABLE Assenza(
    id PoslInteger NOT NULL,
    Persona PoslInteger NOT NULL,
    tipo CausaAssenza NOT NULL, 
    giorno date NOT NULL,
    primary key(id),
    foreign key(persona) references Persona(id),
    unique (persona,giorno)
);
