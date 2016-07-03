---- Functional implementation of the similarity operator.
---- The function gets 2 inputs: requested image and image exisiting in the DB
---- The function return a number (similarity value) returned by LIRE (normally..)
---- The function will call a LIRE-based JAVA code
--create function ImageSimilarity (reqImage in bfile)
--return number as
--language java name 'blablabla';
--
---- Binding the operator to the functional implementation
--create operator Similiarity
--binding (bfile)
--return number using ImageSimilarity;
--
---- Defining a type that implements the ODCIIndex interface
--create type SimilarityIndexMethods(
--    static function ODCIIndexCreate()
--    static function ODCIIndexDrop()
--    static function ODCIIndexInsert()
--    static function ODCIIndexUpdate()
--    static function ODCIIndexDelete()
--    static function ODCIIndexStart()
--    static function ODCIIndexFetch()
--    static function ODCIIndexStop()
--);
--
---- Defining the body of the methods
--create type body SimilarityIndexMethods(
--  static function ODCIIndexCreate()
--  return number
--  as language java 'ODCIIndexImplementation.ODCIIndexCreate() return java.lang.Integer';
--);
--
---- Creating the Similarity indextype schema object
--create indextype SimilarityIndexType
--for Similarity(bfile)
--using SimilarityIndexMethods
--with system managed storage tables;


--create or replace function ODCIIndexCreate
--return number
--as language java name 'ODCIIndexImplementation.ODCIIndexCreate() return java.lang.Integer';
--/
--variable int output;
--call ODCIIndexCreate() into :output;



CREATE OR REPLACE FUNCTION helloworld RETURN VARCHAR2 AS
LANGUAGE JAVA NAME 'Hello.world () return java.lang.String';

declare 
myString VARCHAR2(20):='OKBA';
BEGIN
CALL helloworld() INTO :myString;
END

















