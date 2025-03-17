CREATE TABLE IMPORTED_BOOK (
    BOOKID    NUMBER,
    BOOKNAME  VARCHAR(40),
    PUBLISHER VARCHAR(40),
    PRICE     NUMBER(8)
);

INSERT INTO IMPORTED_BOOK VALUES ( 21,
                                   'Zen Golf',
                                   'Pearson',
                                   12000 );

INSERT INTO IMPORTED_BOOK VALUES ( 22,
                                   'Soccer Skills',
                                   'Human Kinetics',
                                   12000 );
