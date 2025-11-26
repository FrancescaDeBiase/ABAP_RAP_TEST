@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZBIGL_FDB_V2'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_BIGL_FDB_V2
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_BIGL_FDB_V2
  association [1..1] to ZR_BIGL_FDB_V2 as _BaseEntity on $projection.IDBIGLIETTO = _BaseEntity.IDBIGLIETTO
{
  key IdBiglietto,
  @Semantics: {
    User.Createdby: true
  }
  CreationDa,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  CreationA,
  @Semantics: {
    User.Lastchangedby: true
  }
  ModificatoDa,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  ModificatoA,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  Locallastchange,
  _BaseEntity
}
