CREATE TABLE aeronaves(
id serial PRIMARY key,
modelo VARCHAR(100) not null,
codigo_cauda VARCHAR(10) unique not null,
capacidade int not null check(capacidade>0)
);

CREATE TABLE pilotos(
id serial PRIMARY key,
nome VARCHAR(150) not null,
codigo_anac VARCHAR(6) unique not null,
horas_voo int DEFAULT 0 CHECK(horas_voo>=0)
);

CREATE TABLE voos(
id serial PRIMARY key,
aeronaves_id int not null,
FOREIGN KEY (aeronaves_id) REFERENCES aeronaves(id),
pilotos_id int not null,
FOREIGN KEY (pilotos_id) REFERENCES pilotos(id),
numero_voo varchar(50) not null,
origem VARCHAR(100) not null,
destino VARCHAR(100) not null,
data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE voos

CREATE TABLE voos(
id serial PRIMARY key,
aeronaves_id int not null,
FOREIGN KEY (aeronaves_id) REFERENCES aeronaves(id),
pilotos_id int not null,
FOREIGN KEY (pilotos_id) REFERENCES pilotos(id),
numero_voo varchar(50) not null,
origem VARCHAR(100) not null,
destino VARCHAR(100) not null,
data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
status VARCHAR(50) DEFAULT 'agendado' CHECK(status in('agendado', 'em voo', 'concluido', 'cancelado'))
);

CREATE TABLE passageiros(
id serial PRIMARY key,
nome VARCHAR(150) not null,
cpf VARCHAR(11) unique not null,
email varchar(150) unique not null
);

CREATE TABLE passagens(
id serial PRIMARY key,
voos_id int not null,
FOREIGN KEY (voos_id) REFERENCES voos(id),
passageiros_id int not null,
FOREIGN KEY (passageiros_id) REFERENCES passageiros(id),
assento varchar(4) not null,
classe VARCHAR(50) DEFAULT 'economica' check(classe in('economica', 'executiva')),
valor numeric(10,2) CHECK(valor>0.00)

);

INSERT INTO aeronaves(modelo, codigo_cauda, capacidade) VALUES
('avião123', 'ABC-123', 150),
('avião234', 'ABC-234', 200),
('avião456', 'ABC-456', 100),
('avião567', 'ABC-567', 250),
('avião678', 'ABC-678', 300);

SELECT * from aeronaves

INSERT INTO pilotos(nome, codigo_anac, horas_voo) VALUES       
('João Barros', 'ABCDEF', 10 ),
('Gabriel Silva', 'FGHIJK', 15 ),
('Davi Andrade', 'LMNOPQ', 20 ),
('Lorenzo Silva', 'RSTUVW', 9 ),
('Cadu Nunes', 'ALMNOP', 4 );

SELECT * FROM pilotos


INSERT INTO passageiros(nome, cpf, email) VALUES                 //id bugado vai de 4 a 10
('Maria Clara', '11122233344', 'mariaclara@gmail.com'),
('Antonio', '22233344455', 'antonio@gmail.com'),
('Leticia', '55566677788', 'leticia@gmail.com'),
('Luiza', '66677788899', 'luiza@gmail.com'),
('Carlos', '99988877766', 'carlos@gmail.com');

SELECT * from passageiros

INSERT into voos(aeronaves_id, pilotos_id, numero_voo, origem, destino, status) VALUES
(1, 1, '1234', 'Brasil', 'Estados Unidos', 'agendado' ),
(2, 2, '4567', 'Brasil', 'Canada', 'em voo' ),
(3, 3, '7890', 'Canada', 'Brasil', 'concluido' ),
(4, 4, '2345', 'Argentina', 'Portugal', 'cancelado' ),
(5, 5, '4987', 'Portugal', 'Estados Unidos', 'em voo' );

select * from voos

INSERT INTO passagens(voos_id, passageiros_id, assento, classe, valor) VALUES
(1, 6, '12AB', 'economica', 500.00 ),
(2, 7, '22CD', 'executiva', 1000.00 ),
(3, 8, '24EF', 'economica', 700.00),
(4, 9, '35GH', 'executiva', 1300.00 ),
(5, 10,'45TG', 'economica', 400.00 );


SELECT
voos.numero_voo,
voos.origem,
voos.destino,
aeronaves.modelo,
pilotos.nome as piloto
FROM voos join aeronaves on voos.aeronaves_id = aeronaves.id
join pilotos on pilotos.id = voos.pilotos_id 
WHERE voos.status in ('agendada', 'em voo');


SELECT
classe,
sum(valor)
from passagens
group by classe;


SELECT
passageiros.nome as passageiros,
voos.numero_voo,
passagens.assento,
passagens.valor
FROM passagens join passageiros on passagens.passageiros_id = passageiros.id
join voos on passagens.voos_id = voos.id
WHERE passagens.classe = 'executiva'
and passagens.valor >800.00 
order by passagens.valor desc







