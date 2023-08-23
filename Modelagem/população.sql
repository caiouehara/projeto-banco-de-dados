/* Trajeto
INSERT INTO trajeto VALUES (NEXTVAL('cód_trajeto_seq'), 79);
INSERT INTO trajeto VALUES (NEXTVAL('cód_trajeto_seq'), 137);
INSERT INTO trajeto VALUES (NEXTVAL('cód_trajeto_seq'), 287);
INSERT INTO trajeto VALUES (NEXTVAL('cód_trajeto_seq'), 398);
INSERT INTO trajeto VALUES (NEXTVAL('cód_trajeto_seq'), 37);
*/

/* Apoio Trajeto
INSERT INTO apoio_trajeto 
    VALUES 
        (0, 'Frango Assado', 3),
        (1, 'Posto SHELL', 3),
        (2, 'Policia Rodoviária', 3),

        (0, 'Posto Graal', 4),
        (1, 'Lojinha do Amilson', 4),
        (2, 'Telefone SOS', 4),

        (0, 'Borracharia do Zé', 5),
        (1, 'Vilarejo Sol de Minas', 5),
        (2, 'Posto SHELL', 5),

        (0, 'Frango Assado', 6),
        (1, 'Policia Rodoviária', 6),
        (2, 'Telefone Assado', 6),

        (0, 'Posto Graal', 7),
        (1, 'Policia Rodoviária', 7),
        (2, 'Frango Assado', 7);
*/

/* Paradas Trajeto 
INSERT INTO paradas_trajeto 
    VALUES 
        (0, 'Falta de Gasolina', 3),
        (0, 'Estouro do Pneu', 3),
        (0, 'Posto Graal', 7),
*/

/* Paradas Trajeto 
INSERT INTO paradas_trajeto 
    VALUES 
        (0, 'Falta de Gasolina', 3),
        (0, 'Estouro do Pneu', 3),
        (0, 'Posto Graal', 7),
*/

/* Motorista 
INSERT INTO motorista
    VALUES 
        (983363, 'Radeu'),
        (193955, 'Nokeniu'),
        (447634, 'Lipur'),
        (522424, 'Irci'),
        (174551, 'Gotun');
*/

INSERT INTO entrega
    VALUES 
        (NEXTVAL('cód_entrega_seq'), 983363, 3, 4763, "Ribeirão Preto", "São Carlos"),
        (NEXTVAL('cód_entrega_seq'), 193955, 4, 6912, "Ribeirão Preto", "São Carlos"),
        (NEXTVAL('cód_entrega_seq'), 447634, 5, 8713, "São Paulo", "Araraquara"),
        (NEXTVAL('cód_entrega_seq'), 522424, 6, 9135, "São Paulo", "Uberaba"),
        (NEXTVAL('cód_entrega_seq'), 174551, 7, 9913, "Ribeirão Preto", "Sertãozinho");