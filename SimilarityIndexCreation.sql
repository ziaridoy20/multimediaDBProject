-- Functional implementation of the similarity operator.
-- The function gets 2 inputs: requested image and image exisiting in the DB
-- The function return a number (similarity value) returned by LIRE (normally..)
-- The function will call a LIRE-based JAVA code
create function ImageSimilarity (reqImage in bfile, dbImage in bfile)
return number as
language java name
'ODCIImplementation.ODCIOperatorImplementation.ImageSimilarity() return java.lang.Integer';

-- Binding the operator to the functional implementation
create operator Similiarity
binding (bfile, bfile)
return number using ImageSimilarity;

-- Defining a type that implements the ODCIIndex interface
create type SimilarityIndex as object(
    scanctx RAW(4),
    STATIC FUNCTION ODCIGetInterfaces(ifclist OUT SYS.ODCIObjectList)
    RETURN NUMBER,
    static function ODCIIndexCreate(ia SYS.ODCIIndexInfo, parms VARCHAR2,
    env SYS.ODCIEnv) RETURN NUMBER,
    static function ODCIIndexDrop(ia SYS.ODCIIndexInfo, env SYS.ODCIEnv)
    return number,
    static function ODCIIndexInsert(ia SYS.ODCIIndexInfo, rid VARCHAR2,
    newval VARCHAR2, env SYS.ODCIEnv)
    return number,
    static function ODCIIndexUpdate(ia SYS.ODCIIndexInfo, rid VARCHAR2,
    oldval VARCHAR2, newval VARCHAR2, env SYS.ODCIEnv)
    return number,
    static function ODCIIndexDelete(ia SYS.ODCIIndexInfo, rid VARCHAR2,
    oldval VARCHAR2, env SYS.ODCIEnv)
    return number,
    static function ODCIIndexStart(sctx IN OUT psbtree_im, ia SYS.ODCIIndexInfo,
    op SYS.ODCIPredInfo, qi sys.ODCIQueryInfo, strt number, stop number,
    cmpval VARCHAR2, env SYS.ODCIEnv)
    return number,
    member function ODCIIndexFetch(nrows NUMBER, rids OUT SYS.ODCIridlist,
    env SYS.ODCIEnv)
    return number,
    member function ODCIIndexClose(env SYS.ODCIEnv)
    return number
);

-- Defining the body of the methods
create type body SimilarityIndex
is
  STATIC FUNCTION ODCIGetInterfaces(ifclist OUT SYS.ODCIObjectList)
  return number
  as language java name 
  'ODCIImplementation.ODCIMethodsImplementation.ODCIGetInterfaces() return java.lang.Integer';
  
  static function ODCIIndexCreate(ia SYS.ODCIIndexInfo, parms VARCHAR2,
  env SYS.ODCIEnv)
  return number
  as language java name
  'ODCIImplementation.ODCIMethodsImplementation.ODCIIndexCreate() return java.lang.Integer';

  static function ODCIIndexDrop(ia SYS.ODCIIndexInfo, env SYS.ODCIEnv)
  return number
  as language java name
  'ODCIIndexImplementation.ODCIIndexDrop() return java.lang.Integer';  

  static function ODCIIndexInsert(ia SYS.ODCIIndexInfo, rid VARCHAR2,
  newval VARCHAR2, env SYS.ODCIEnv)
  return number
  as language java name
  'ODCIImplementation.ODCIMethodsImplementation.ODCIIndexInsert() return java.lang.Integer';
  
  static function ODCIIndexUpdate(ia SYS.ODCIIndexInfo, rid VARCHAR2,
  oldval VARCHAR2, newval VARCHAR2, env SYS.ODCIEnv)
  return number
  as language java name
  'ODCIImplementation.ODCIMethodsImplementation.ODCIIndexUpdate() return java.lang.Integer';
  
  static function ODCIIndexDelete(ia SYS.ODCIIndexInfo, rid VARCHAR2,
  oldval VARCHAR2, env SYS.ODCIEnv)
  return number
  as language java name
  'ODCIImplementation.ODCIMethodsImplementation.ODCIIndexDelete() return java.lang.Integer';

  static function ODCIIndexStart(sctx IN OUT psbtree_im, ia SYS.ODCIIndexInfo,
  op SYS.ODCIPredInfo, qi sys.ODCIQueryInfo, strt number, stop number,
  cmpval VARCHAR2, env SYS.ODCIEnv)
  return number
  as language java name
  'ODCIImplementation.ODCIMethodsImplementation.ODCIIndexStart() return java.lang.Integer';
  
  member function ODCIIndexFetch(nrows NUMBER, rids OUT SYS.ODCIridlist,
  env SYS.ODCIEnv)
  return number
  as language java name
  'ODCIImplementation.ODCIMethodsImplementation.ODCIIndexFetch() return java.lang.Integer';
  
  member function ODCIIndexClose(env SYS.ODCIEnv)
  return number
  as language java name
  'ODCIImplementation.ODCIMethodsImplementation.ODCIIndexClose() return java.lang.Integer';
end;
  
-- Creating the Similarity indextype schema object
create indextype SimilarityIndexType
for Similarity(bfile)
using SimilarityIndex
with system managed storage tables;

